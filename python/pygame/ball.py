import random
import pygame


class Ball:
    radius = 10
    pos = pygame.Vector2()
    vel = pygame.Vector2()

    def __init__(self, screen):
        self.reset(screen)
    
    def reset(self, screen):
        self.pos.x = screen.get_width() // 2
        self.pos.y = screen.get_height() // 2

        self.speed = 4
        
        if self.vel.x < 0:
            self.vel.x = self.speed
        else:
            self.vel.x = -self.speed

        self.bounce()
    
    def bounce(self):
        self.vel.y = random.choice([self.speed // 2,  -self.speed // 2])

    def draw(self, screen):
        pygame.draw.circle(screen, "white", self.pos, self.radius)

    def out_to_right(self, screen):
        return self.pos.x - self.radius > screen.get_width()
    
    def out_to_left(self):
        return self.pos.x + self.radius < 0
    
    def update(self, screen):
        self.pos.x += self.vel.x
        self.pos.y += self.vel.y

        if self.pos.y + self.radius > screen.get_height():
            self.vel.y = -self.speed // 2
        
        if self.pos.y - self.radius < 0:
            self.vel.y = self.speed // 2
