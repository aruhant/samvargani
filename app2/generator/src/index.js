var Canvas = require('canvas');
var Crossword = require('crossword');
const { createCanvas, loadImage } = require('canvas')
const fs = require('fs');

var width = 20;
var height = 15;
const canv = createCanvas(40 * width, 40 * height);

const outputImg = 'outputImg.png';
var game = new Crossword(canv, width, height);
game.clearCanvas(true);

var sourceFile = process.argv[2];
var buffer = fs.readFileSync(sourceFile, { encoding: 'utf-8' });
var lines = buffer.trim().split(/[\r|\n]+/);
lines.sort(function () {
  return Math.random() - 0.5;
});
function addClue(i) {
  if (i >= lines.length) {
    console.log(JSON.stringify(
      game.grid.map(function (row) {
        return row.map(function (cell) {
          return cell ? cell.letter : ' ';
        }).join('');
      })
    )); var output = fs.createWriteStream(outputImg);
    var stream = canv.pngStream()
      .on('data', function (chunk) {
        output.write(chunk);
      })
      .on('end', function () {
        console.log('completed output to ' + outputImg);
      });
    return;
  }
  game.addWord(lines[i], function (err, anchor, direction) {
    if (err) {
      console.log(err);
    } else {
      console.log(anchor + ' ' + direction + ': ' + lines[i]);
    }
    addClue(i + 1);
  });
}
addClue(0);



