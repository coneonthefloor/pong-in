import pygame
from ball import Ball
from paddle import Paddle

WIDTH = 640
HEIGHT = 480

pygame.init()
screen = pygame.display.set_mode((WIDTH, HEIGHT))
clock = pygame.time.Clock()
running = True

ball = Ball(screen)
left_paddle = Paddle(20, HEIGHT // 2 - 50)
right_paddle = Paddle(WIDTH - 40, HEIGHT // 2 - 50)


def update():
    ball.update(screen)
    left_paddle.update(screen)
    right_paddle.update(screen)

    if ball.out_to_right(screen):
        left_paddle.score += 1
        ball.reset(screen)
    
    if ball.out_to_left():
        right_paddle.score += 1
        ball.reset(screen)

    if ball.vel.x > 0:
        right_paddle.chase_ball(ball, screen)
        left_paddle.move_to_center(screen)
    else:
        right_paddle.move_to_center(screen)
        left_paddle.chase_ball(ball, screen)

    if left_paddle.hits_ball(ball):
        ball.vel.x = ball.speed
        ball.speed += 0.1
        ball.bounce()
    
    if right_paddle.hits_ball(ball):
        ball.vel.x = -ball.speed
        ball.speed += 0.1
        ball.bounce()


def draw():
    screen.fill("black")

    for y in range(0, HEIGHT, HEIGHT//10):
        pygame.draw.rect(screen, "white", (WIDTH//2 - 1, y, 2, HEIGHT//20))

    font = pygame.font.Font(None, 20)
    text = font.render(str(left_paddle.score) + "     " + str(right_paddle.score), True, "white")
    text_rect = text.get_rect(center=(WIDTH//2, 20))
    screen.blit(text, text_rect)

    ball.draw(screen)
    left_paddle.draw(screen)
    right_paddle.draw(screen)


while running:
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            running = False

    update()
    draw()

    pygame.display.flip()

    clock.tick(60)

pygame.quit()