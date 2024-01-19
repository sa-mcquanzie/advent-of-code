/*jshint esversion: 9 */

class Cell {
  constructor(x, y, legend, exits, path, outside, start, visited) {
    this.x = x;
    this.y = y;
    this.legend = legend;
    this.exits = exits;
    this.path = false;
    this.outside = false;
    this.start = legend === 'S';
    this.visited = false;
    this.showing = false;
  }
  
  show() {
    if (this.showing) {
      fill('black');
      rect(this.x, this.y, 2, 2);     
    }
  }
}

const exit_directions = {
  '|': [[0, -1], [0,  1]],
  '-': [[-1, 0], [1,  0]],
  'L': [[0, -1], [1,  0]],
  'J': [[0, -1], [-1, 0]],
  '7': [[-1, 0], [0,  1]],
  'F': [[0,  1], [1,  0]],
  'S': [[0, -1], [0,  1]],
  '.': []
};

const createField = (input) => {
  const cells = {};
  const mapData = input.map((line) => line.trim().split(''));

  mapData.forEach((row, row_idx) => {
    row.forEach((legend, col_idx) => {
      const directions = [...exit_directions[legend]];

       const exits = directions.filter((co_ord) => {
        return !(
          (row_idx === 0 && co_ord.at(-1)) < 0 ||
          (col_idx === 0 && co_ord.at(1)) < 0 ||
          (col_idx === row.length - 1) && co_ord.at(1) > 0 ||
          (row_idx === input.length - 1) && co_ord.at(-1) > 0
        )}).map((co_ord) => (
         [(co_ord.at(0) + col_idx) * 2, (co_ord.at(-1) + row_idx) * 2]
        ));
      
      const k = `${col_idx * 2},${row_idx* 2}`;
      cells[k] = new Cell(col_idx * 2, row_idx * 2, legend, exits);
    });
  });
  
  return cells;
};

const takeSteps = (start_co_ords, pipes, distance, visited) => {
  let stack = [start_co_ords];

  while (stack.length > 0) {
    co_ords = stack.pop();

    pipes[co_ords].visited = true;
    visited.push(co_ords);

    distance += 1;

    allNextExits = pipes[co_ords].exits;
    unvisitedExit = allNextExits.find((ex) => !pipes[ex].visited);

    if (!unvisitedExit) return distance;

    stack.push([unvisitedExit]);
  }
};

const findPath = (pipes, visited) => {
  const first = pipes[Object.entries(pipes).find(([_, val]) => val.start)[0]];

  result = Math.ceil(takeSteps(first.exits[0], pipes, 0, visited) / 2)
  console.log(result);
  
  return result;
}

const direction = (dir, co_ords) => {
  if (dir == 'n') return [co_ords[0], co_ords[1] - 1];
  if (dir == 'e') return [co_ords[0] + 1, co_ords[1]];
  if (dir == 's') return [co_ords[0], co_ords[1] + 1];
  if (dir == 'w') return [co_ords[0] - 1, co_ords[1]];
}

function preload() {
  input = loadStrings('../../inputs');
}

function setup() {
  visitedCells = []
  field = createField(input);
  findPath(field, visitedCells);
  
  createCanvas(input[0].length * 2, input.length * 2);
  background(220);
  
  fill('black');
  
  pathCount = 0;
  rate = 10;
}
  
function draw() {
  if (pathCount < visitedCells.length - 1) {
    rect(visitedCells[pathCount][0][0], visitedCells[pathCount][0][1], 2, 2)
    pathCount += 1;
  } else {
    noLoop();
  }
}