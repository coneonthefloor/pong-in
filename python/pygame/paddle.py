import pygame


class Paddle:
    speed = 4
    width = 10
    height = 100

    def __init__(self, x, y):
        self.score = 0
        self.pos = pygame.Vector2(x, y)
        self.vel = pygame.Vector2()

    def draw(self, screen):
        pygame.draw.rect(screen, "white", (self.pos.x, self.pos.y, self.width, self.height))

    def update(self, screen):
        self.pos.x += self.vel.x
        self.pos.y += self.vel.y
        self.keep_in_bounds(screen)

    def keep_in_bounds(self, screen):
        if self.pos.y < 0:
            self.pos.y = 0
        
        if self.pos.y + self.height > screen.get_height():
            self.pos.y = screen.get_height() - self.height

    def chase_ball(self, ball, screen):
        target = pygame.Vector2(self.pos.x, ball.pos.y - self.height // 2)
        self.pos = self.pos.move_towards(target,self.speed)
        self.keep_in_bounds(screen)

    def move_to_center(self, screen):
        target = pygame.Vector2(self.pos.x, screen.get_height() // 2 - self.height // 2)
        self.pos = self.pos.move_towards(target,self.speed)

    def hits_ball(self, ball):
        paddle_rect = pygame.Rect(self.pos.x, self.pos.y, self.width, self.height)
        ball_rect = pygame.Rect(ball.pos.x, ball.pos.y, ball.radius, ball.radius)
        return paddle_rect.colliderect(ball_rect)