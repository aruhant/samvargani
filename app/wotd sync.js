var FIREBASE_URL = PropertiesService.getScriptProperties().getProperty('FIREBASE_URL');
var CLIENT_EMAIL = PropertiesService.getScriptProperties().getProperty('CLIENT_EMAIL');
var PRIVATE_KEY = PropertiesService.getScriptProperties().getProperty('PRIVATE_KEY');

var SHEET_NAME = "wotd";
var FIREBASE_PATH = "wotd";

/**
 * Creates and returns an OAuth2 service for Firebase.
 */
function getFirebaseService() {
  var scriptProperties = PropertiesService.getScriptProperties();
  var clientEmail = CLIENT_EMAIL;
  var privateKey = PRIVATE_KEY;

  if (privateKey) {
      // Replace literal stored newlines (\n) with actual newline characters
      privateKey = privateKey.replace(/\\n/g, '\n'); 
  }

  return OAuth2.createService('Firebase')
    .setTokenUrl('https://oauth2.googleapis.com/token')
    .setPrivateKey(privateKey)
    .setIssuer(clientEmail)
    .setPropertyStore(PropertiesService.getScriptProperties())
    .setScope(['https://www.googleapis.com/auth/firebase.database', 'https://www.googleapis.com/auth/userinfo.email']);
}

/**
 * Initializes the Firebase connection with an OAuth2 token.
 */
function getFirebaseInstance() {
  var service = getFirebaseService();
  if (service.hasAccess()) {
    var token = service.getAccessToken();
    return FirebaseApp.getDatabaseByUrl(FIREBASE_URL, token);
  } else {
    Logger.log('Firebase authentication error: ' + service.getLastError());
    return null;
  }
}

/**
 * Validates if a string is a valid hex color code
 */
function isValidHexColor(color) {
  if (typeof color !== 'string') return false;

  if (color.startsWith('#')) {
    color = color.slice(1);
  }

  return /^[0-9A-Fa-f]{6}$/.test(color);
}

/**
 * Validates a property based on its expected type
 */
function validateProperty(name, value, expectedType) {
  let result = {
    value: value,
    error: false
  };

  if (value === "" || value === null || value === undefined) {
    if (name === "answer" || name === "meaning") {
      result.error = true;
      Logger.log("Error: Required property '" + name + "' is missing");
      return { value: null, error: true };
    }
    else {
      return { value: null, error: false };
    }
  }

  switch (expectedType) {
    case "string":
      if (typeof value !== "string") {
        result.value = String(value);
      }

      if (name === "backgroundColor") {
        if (!isValidHexColor(value)) {
          Logger.log("Error: Property '" + name + "' should be a valid hex color, got: " + value);
          result.error = true;
        }
      }
      break;

    case "number":
      if (isNaN(Number(value))) {
        Logger.log("Error: Property '" + name + "' should be a number, got: " + value);
        result.error = true;
      } else {
        result.value = Number(value);
      }
      break;

    case "boolean":
      if (typeof value === "string") {
        value = value.trim().toLowerCase();
        if (value === "true" || value === "yes" || value === "1") {
          result.value = true;
        } else if (value === "false" || value === "no" || value === "0") {
          result.value = false;
        } else {
          Logger.log("Error: Property '" + name + "' should be a boolean, got: " + value);
          result.error = true;
        }
      } else if (typeof value !== "boolean") {
        result.value = Boolean(value);
        result.error = true;
        Logger.log("Error: Property '" + name + "' should be a boolean, got: " + value);
      }
      break;

    case "array":
      if (typeof value === "string") {
        result.value = value.split(",").map(item => item.trim());
      } else if (!Array.isArray(value)) {
        result.value = [value];
      }

      if (name === "colors") {
        for (let i = 0; i < result.value.length; i++) {
          if (!isValidHexColor(result.value[i])) {
            Logger.log("Error: Element in '" + name + "' array should be a valid hex color, got: " + result.value[i]);
            result.error = true;
          }
        }
      }
      break;

    default:
      break;
  }

  return result;
}

/**
 * Syncs the entire sheet to Firebase.
 */
function syncSheetToFirebase() {
  var firebase = getFirebaseInstance();
  if (!firebase) {
    Logger.log("Failed to get Firebase instance. Check authentication.");
    return;
  }

  var sheet = SpreadsheetApp.getActiveSpreadsheet().getSheetByName(SHEET_NAME);
  var data = sheet.getDataRange().getValues();
  var headers = data.shift();
  var jsonData = {};
  jsonData["test"] = "value";

  function daysSinceEpoch(dateString) {
    var date = new Date(dateString);
    var msSinceEpoch = date.getTime();
    var days = Math.floor(msSinceEpoch / 86400000);
    return days;
  }

  var error = false;

  data.forEach(function (row, rowIndex) {

    var dateIndex = headers.indexOf("date");
    var dateValue = row[dateIndex];

    if (!dateValue || String(dateValue).trim() === "")  return; // Skips the rest of the loop for this row
    

    var rowObject = {};
    var errorInThisRow = false;

    headers.forEach(function (header, index) {
      var value = row[index];

      let validation;

      switch (header) {
        case "date":
          validation = validateProperty(header, value, "string");
          break;
        case "answer":
        case "meaning":
        case "title":
        case "backgroundColor":
          validation = validateProperty(header, value, "string");
          break;

        case "icons":
        case "images":
        case "hints":
        case "colors":
          validation = validateProperty(header, value, "array");
          break;

        case "moveHorizontal":
        case "moveVertical":
          validation = validateProperty(header, value, "boolean");
          break;

        case "maxOpacity":
        case "minOpacity":
        case "maxSize":
        case "minSize":
        case "maxSpeed":
        case "minSpeed":
        case "itemsCount":
        case "whenToShowIcons":
        case "difficulty":
          validation = validateProperty(header, value, "number");
          break;

        default:
          break;
      }
      errorInThisRow = errorInThisRow || validation.error;
      if (header !== "date" && validation.value != null) {
        rowObject[header] = validation.value;
      }

    });

    if (errorInThisRow) {
      error = true;
      Logger.log("Error in row " + (rowIndex + 2) + ". Please fix before syncing.");
    }
    try {
      let dayNumber = daysSinceEpoch(row[headers.indexOf("date")]);
      // dayNumber = daysSinceEpoch(row[0]);
      if (isNaN(dayNumber)) {
        throw new Error("Invalid date format in row " + (rowIndex + 2) + ": " + row[0]);
      }
      if (dayNumber in jsonData) {
        throw new Error("Duplicate date found in row " + (rowIndex + 2) + ": " + row[0]);
      }
      if (dayNumber < daysSinceEpoch(new Date()) - 7) {
        Logger.log("Row " + (rowIndex + 2) + " skipped. Older than 7 days ago.");
      } else {
        Logger.log("Row " + (rowIndex + 2) + " processed successfully.");
        jsonData[dayNumber] = rowObject;
      }
    } catch (e) {
      Logger.log("Error processing row " + (rowIndex + 2) + ": " + e.message);
      Logger.log(row[rowIndex + 2]);
    }
  });

  if (error) {
    throw Error("FIX ERRORS BEFORE SYNCING");
  }

  for (var key in jsonData) {
    firebase.setData(FIREBASE_PATH + "/" + key, jsonData[key]);
  }
  // firebase.setData(FIREBASE_PATH, jsonData);
  Logger.log("Data successfully synced to Firebase.");
}

function onOpen() {
  var ui = SpreadsheetApp.getUi();
  ui.createMenu('WOTD Sync')
    .addItem('Sync to Firebase', 'syncSheetToFirebase')
    .addToUi();
}