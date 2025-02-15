function love.load()
    target = {}
    target.x = 300
    target.y = 300
    target.radius = 50

    score = 0
    timer = 0
    gameState = 1

    --set font size, can take in extra params to actually change the font. look into documentation
    gameFont = love.graphics.newFont(40)

    sprites = {}
    sprites.sky = love.graphics.newImage('assets/sky.png')
    sprites.target = love.graphics.newImage('assets/target.png')
    sprites.crosshairs = love.graphics.newImage('assets/crosshairs.png')

    love.mouse.setVisible(false)
end

function love.update(dt)
    if timer > 0 then
        timer = timer - dt 
    end
    if timer < 0 then
        timer = 0
        gameState = 1 
    end
end

function love.draw()
    love.graphics.draw(sprites.sky, 0, 0)

    --setColor uses 0 - 1 scale instead of 255, so if using 255 simply divide by 255
    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(gameFont)
    -- .. combines left and right
    love.graphics.print("Score: " .. score, 5, 5)
    love.graphics.print("Time: " .. math.ceil(timer), 300, 5)

    if gameState == 1 then
        love.graphics.printf("Click anywhere to being!", 0, 250, love.graphics.getWidth(), "center")
    end

    if gameState == 2 then
        love.graphics.draw(sprites.target, target.x - target.radius, target.y - target.radius)
        love.graphics.draw(sprites.crosshairs, love.mouse.getX()-20, love.mouse.getY()-20)
    end
end

function love.mousepressed(x, y, button, istouch, presses)
    if gameState == 2 then
        local mouseToTarget = distanceBetween(x, y, target.x, target.y)
        if mouseToTarget < target.radius then
            if button == 1 then
                score = score + 1 
                timer = timer + 0.25
            elseif button == 2 then
                score = score + 2
                timer = timer - 1
            end
            target.x = math.random(target.radius, love.graphics.getWidth() - target.radius)
            target.y = math.random(target.radius, love.graphics.getHeight() - target.radius)
        elseif score > 0 then
            score = score - 1
        end
    elseif button == 1 and gameState == 1 then
        gameState = 2
        timer = 15
        score  = 0
    end
end

-- function to calculate the distance between the mouse and the middle of the circle
function distanceBetween(x1, y1, x2, y2)
    return math.sqrt( (x2 - x1)^2 + (y2 - y1)^2 )
end