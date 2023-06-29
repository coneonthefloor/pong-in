function ballCreate()
    return {x = 0, y = 0, vx = 4, vy = 0, radius = 10, speed = 4}
end

function ballReset(ball, screenWidth, screenHeight)
    if ball.x < 0 then
        ball.vx = ball.speed
    end

    if ball.x > 0 then
        ball.vx = -ball.speed
    end

    ball.x = screenWidth / 2
    ball.y = screenHeight / 2
    ball.speed = 4

    ballBounce(ball)
end

function ballOutToLeft(ball)
    return ball.x + ball.radius < 0
end

function ballOutToRight(ball, screenWidth)
    return ball.x - ball.radius > screenWidth
end

function ballBounce(ball)
    if love.math.random() > .5 then
        ball.vy = -ball.speed / 2
    else
        ball.vy = ball.speed / 2
    end
end

function ballDraw(ball)
    love.graphics.setColor(255, 255, 255, 1)
    love.graphics.circle("fill", ball.x, ball.y, ball.radius)
end

function ballUpdate(ball)
    ball.x = ball.x + ball.vx
    ball.y = ball.y + ball.vy
end

function paddleCreate()
    return {x = 0, y = 0, vx = 0, vy = 0, width = 10, height = 100, speed = 4, score = 0}
end

function paddleDraw(paddle)
    love.graphics.setColor(255, 255, 255, 1)
    love.graphics.rectangle("fill", paddle.x, paddle.y, paddle.width, paddle.height)
end

function paddleUpdate(paddle, screenHeight)
    paddle.x = paddle.x + paddle.vx
    paddle.y = paddle.y + paddle.vy

    if paddle.y < 0 then
        paddle.y = 0
    end

    if paddle.y + paddle.height > screenHeight then
        paddle.y = paddle.y - paddle.height
    end
end

function paddleMoveOnYAxis(paddle, targetY)
    toVectorY = targetY - paddle.y

    sqDist = toVectorY * toVectorY

    if sqDist == 0 or (paddle.speed >= 0 and sqDist <= paddle.speed * paddle.speed) then
        return
    end

    dist = math.sqrt(sqDist)
    newY = paddle.y + (toVectorY / dist) * paddle.speed

    paddle.y = newY
end

function paddleMoveToBall(paddle, ball)
    paddleMoveOnYAxis(paddle, ball.y - paddle.height / 2)
end

function paddleMoveToCenter(paddle, screenHeight)
    paddleMoveOnYAxis(paddle, screenHeight / 2 - paddle.height / 2)
end

function paddleHitsBall(paddle, ball)
    return ball.x > paddle.x and
    ball.x < paddle.x + paddle.width and
    ball.y > paddle.y and
    ball.y < paddle.y + paddle.height
end

function love.load()
    screenWidth = 640
    screenHeight = 480
    love.window.setMode(screenWidth, screenHeight)

    local font = love.graphics.getFont()
    score = {}
    score.text = love.graphics.newText(font, "")
    score.x = screenWidth / 2
    score.y = 20

    dashes = {}
    maxDashes = 100
    dashLength = screenHeight / maxDashes
    for i = 1, maxDashes do
        dashes[i] = {screenWidth / 2, i * dashLength}
    end

    ball = ballCreate()
    ballReset(ball, screenWidth, screenHeight)

    leftPaddle = paddleCreate()
    leftPaddle.x = 20
    leftPaddle.y = screenHeight / 2 - leftPaddle.height / 2
    rightPaddle = paddleCreate()
    rightPaddle.x = screenWidth - 40
    rightPaddle.y = screenHeight / 2 - rightPaddle.height / 2
end

function love.update()
    score.text:set(leftPaddle.score .. "   " .. rightPaddle.score)

    ballUpdate(ball)

    if ballOutToLeft(ball) then
        ballReset(ball, screenWidth, screenHeight)
        rightPaddle.score = rightPaddle.score + 1
    end

    if ballOutToRight(ball, screenWidth) then
        ballReset(ball, screenWidth, screenHeight)
        leftPaddle.score = leftPaddle.score + 1
    end

    if ball.y - ball.radius <= 0 then
        ball.vy = ball.speed / 2
    end

    if ball.y + ball.radius >= screenHeight then
        ball.vy = -ball.speed / 2
    end

    if ball.vx < 0 then
        paddleMoveToBall(leftPaddle, ball)
        paddleMoveToCenter(rightPaddle, screenHeight)
    end

    if ball.vx > 0 then
        paddleMoveToBall(rightPaddle, ball)
        paddleMoveToCenter(leftPaddle, screenHeight)
    end

    if paddleHitsBall(leftPaddle, ball) then
        ball.speed = ball.speed + 0.1
        ball.vx = ball.speed
        ballBounce(ball)
    end

    if paddleHitsBall(rightPaddle, ball) then
        ball.speed = ball.speed + 0.1
        ball.vx = -ball.speed
        ballBounce(ball)
    end
end

function love.draw()
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.rectangle("fill", 0, 0, screenWidth, screenHeight)

    love.graphics.setColor(255, 255, 255, 1)
    love.graphics.points(dashes)

    love.graphics.draw(score.text, score.x - score.text:getWidth() / 2, score.y)

    ballDraw(ball)
    paddleDraw(leftPaddle)
    paddleDraw(rightPaddle)
end
