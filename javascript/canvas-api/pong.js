const $canvas = document.createElement("canvas");
const canvasWidth = ($canvas.width = 640);
const canvasHeight = ($canvas.height = 480);
const ctx = $canvas.getContext("2d");
document.body.appendChild($canvas);

function clamp(num, min, max) {
  return Math.min(Math.max(num, min), max);
}

function moveTowards(current, target, maxDistanceDelta) {
  const toVectorX = target.x - current.x;
  const toVectorY = target.y - current.y;

  const sqDist = toVectorX * toVectorX + toVectorY * toVectorY;

  if (
    sqDist == 0 ||
    (maxDistanceDelta >= 0 && sqDist <= maxDistanceDelta * maxDistanceDelta)
  )
    return { x: target.x, y: target.y };

  const dist = Math.sqrt(sqDist);
  const x = current.x + (toVectorX / dist) * maxDistanceDelta;
  const y = current.y + (toVectorY / dist) * maxDistanceDelta;
  return { x, y };
}

function ballCollidesWithPaddle(paddle) {
  return (
    game.ball.x > paddle.x &&
    game.ball.x < paddle.x + paddle.width &&
    game.ball.y > paddle.y &&
    game.ball.y < paddle.y + paddle.height
  );
}

function movePaddleToBall(paddle) {
  const dest = moveTowards(
    paddle,
    { x: paddle.x, y: game.ball.y - paddle.height / 2 },
    paddle.speed
  );

  paddle.y = dest.y;
}

function movePaddleToCenter(paddle) {
  const dest = moveTowards(
    paddle,
    { x: paddle.x, y: canvasHeight / 2 - paddle.height / 2 },
    paddle.speed
  );

  paddle.y = dest.y;
}

class Paddle {
  constructor() {
    this.x = 0;
    this.y = 0;
    this.vy = 0;
    this.score = 0;
    this.speed = 4;
    this.width = 20;
    this.height = 100;
  }
}

class Ball {
  constructor() {
    this.x = 0;
    this.y = 0;
    this.vx = 0;
    this.vy = 0;
    this.speed = 4;
    this.radius = 10;
  }
}

const game = {
  ball: new Ball(),
  leftPaddle: new Paddle(),
  rightPaddle: new Paddle(),
};

function draw() {
  ctx.fillStyle = "black";
  ctx.fillRect(0, 0, canvasWidth, canvasHeight);

  ctx.fillStyle = "white";
  ctx.strokeStyle = "white";

  ctx.beginPath();
  ctx.setLineDash([5, 15]);
  ctx.moveTo(canvasWidth / 2, 0);
  ctx.lineTo(canvasWidth / 2, canvasHeight);
  ctx.stroke();

  ctx.font = "20px monospace";

  const leftScoreWidth = ctx.measureText(game.leftPaddle.score).width;
  ctx.fillText(
    game.leftPaddle.score,
    canvasWidth / 2 - leftScoreWidth - 20,
    20
  );
  ctx.fillText(game.rightPaddle.score, canvasWidth / 2 + 20, 20);

  ctx.beginPath();
  ctx.arc(game.ball.x, game.ball.y, game.ball.radius, 0, 2 * Math.PI);
  ctx.closePath();
  ctx.fill();

  ctx.fillRect(
    game.leftPaddle.x,
    game.leftPaddle.y,
    game.leftPaddle.width,
    game.leftPaddle.height
  );

  ctx.fillRect(
    game.rightPaddle.x,
    game.rightPaddle.y,
    game.rightPaddle.width,
    game.rightPaddle.height
  );
}

function resetBall() {
  game.ball.x = canvasWidth / 2;
  game.ball.y = canvasHeight / 2;

  game.ball.vx = game.ball.vx > 0 ? -game.ball.speed : game.ball.speed;
  game.ball.vy =
    Math.random() > 0.5 ? -game.ball.speed / 2 : game.ball.speed / 2;
}

function update() {
  game.ball.x += game.ball.vx;
  game.ball.y += game.ball.vy;

  if (game.ball.x - game.ball.radius > canvasWidth) {
    game.leftPaddle.score++;
    resetBall();
  }

  if (game.ball.x + game.ball.radius < 0) {
    game.rightPaddle.score++;
    resetBall();
  }

  if (game.ball.vx < 0) {
    movePaddleToBall(game.leftPaddle);
    movePaddleToCenter(game.rightPaddle);
  }

  if (game.ball.vx > 0) {
    movePaddleToBall(game.rightPaddle);
    movePaddleToCenter(game.leftPaddle);
  }

  if (ballCollidesWithPaddle(game.leftPaddle)) {
    game.ball.vx = game.ball.speed;
  }

  if (ballCollidesWithPaddle(game.rightPaddle)) {
    game.ball.vx = -game.ball.speed;
  }

  if (game.ball.y + game.ball.radius > canvasHeight) {
    game.ball.vy = -game.ball.speed;
  }

  if (game.ball.y - game.ball.radius < 0) {
    game.ball.vy = game.ball.speed;
  }

  game.leftPaddle.y = clamp(
    game.leftPaddle.y + game.leftPaddle.vy,
    0,
    canvasHeight - game.leftPaddle.height
  );

  game.rightPaddle.y = clamp(
    game.rightPaddle.y + game.rightPaddle.vy,
    0,
    canvasHeight - game.rightPaddle.height
  );
}

function loop() {
  window.requestAnimationFrame(loop);

  update();
  draw();
}

function init() {
  resetBall();

  game.leftPaddle.x = 20;
  game.leftPaddle.y = canvasHeight / 2 - game.leftPaddle.height / 2;

  game.rightPaddle.x = canvasWidth - 20 - game.rightPaddle.width;
  game.rightPaddle.y = canvasHeight / 2 - game.rightPaddle.height / 2;
}

window.onload = () => {
  init();
  loop();
};
