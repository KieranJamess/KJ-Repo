# This was my first attempt using pygame. It's not the prettiest!

import pygame
import random
pygame.init()

score = 0
font = pygame.font.SysFont('comicsans', 60)
win = pygame.display.set_mode((1000,300))
win.fill((255,255,255))

class button():
    def __init__(self, color, x, y, width, height, text=''):
        self.color = color
        self.x = x
        self.y = y
        self.width = width
        self.height = height
        self.text = text

    def draw(self, win, outline=None):
        if outline:
            pygame.draw.rect(win, outline, (self.x - 2, self.y - 2, self.width + 4, self.height + 4), 0)

        pygame.draw.rect(win, self.color, (self.x, self.y, self.width, self.height), 0)

        if self.text != '':
            font = pygame.font.SysFont('comicsans', 60)
            text = font.render(self.text, 1, (0, 0, 0))
            win.blit(text, (
            self.x + (self.width / 2 - text.get_width() / 2), self.y + (self.height / 2 - text.get_height() / 2)))

    def isOver(self, pos):
        if pos[0] > self.x and pos[0] < self.x + self.width:
            if pos[1] > self.y and pos[1] < self.y + self.height:
                return True

        return False

def redrawWindow():
    win.fill((255,255,255))
    greenButton.draw(win, (0,0,0))
    greenButton2.draw(win, (0,0,0))
    greenButton3.draw(win, (0,0,0))

def mouseover():
    if event.type == pygame.MOUSEMOTION:
        if greenButton.isOver(pos):
            greenButton.color = (255, 0, 0)
        else:
            greenButton.color = (0, 255, 0)

    if event.type == pygame.MOUSEMOTION:
        if greenButton2.isOver(pos):
            greenButton2.color = (255, 0, 0)
        else:
            greenButton2.color = (0, 255, 0)

    if event.type == pygame.MOUSEMOTION:
        if greenButton3.isOver(pos):
            greenButton3.color = (255, 0, 0)
        else:
            greenButton3.color = (0, 255, 0)
            
def wintext():
    textsurface = font.render('You win', True, (255, 0, 0))
    win.fill((255, 255, 255), rect=textsurface.get_rect(topleft=(440, 50)))
    win.blit(textsurface, (440, 50))

def losttext():
    textsurface = font.render('You lost', True, (255, 0, 0))
    win.fill((255, 255, 255), rect=textsurface.get_rect(topleft=(440, 50)))
    win.blit(textsurface, (440, 50))

def scoretext():
    textsurface = font.render(f'Your score is {score}', True, (255, 0, 0))
    win.fill((255, 255, 255), rect=textsurface.get_rect(topleft=(375, 250)))
    win.blit(textsurface, (375, 250))


run = True

greenButton = button ((0,255,0), 400, 100, 250, 100, 'Paper')
greenButton2 = button ((0, 255, 0), 100, 100, 250, 100, 'Rock')
greenButton3 = button ((0, 255, 0), 700, 100, 250, 100, 'Scissors')

redrawWindow()
while run:
    pygame.display.update()

    for event in pygame.event.get():
        pos = pygame.mouse.get_pos()

        mouseover()

        rps = ['Rock', 'Paper', 'Scissors']
        rps_cpu = random.choice(rps)

        if event.type == pygame.MOUSEBUTTONDOWN:
            if greenButton.isOver(pos):
                if rps_cpu == 'Scissors':
                    print('You Lose')
                    score = score - 1
                    losttext()
                    scoretext()
                elif rps_cpu == 'Rock':
                    print('You Win')
                    score = score + 1
                    wintext()
                    scoretext()

        if event.type == pygame.MOUSEBUTTONDOWN:
            if greenButton2.isOver(pos):
                if rps_cpu == 'Paper':
                    print('You Lose')
                    score = score - 1
                    losttext()
                    scoretext()
                elif rps_cpu == 'Scissors':
                    print('You Win')
                    score = score + 1
                    wintext()
                    scoretext()

        if event.type == pygame.MOUSEBUTTONDOWN:
            if greenButton3.isOver(pos):
                if rps_cpu == 'Rock':
                    print('You Lose')
                    score = score - 1
                    losttext()
                    scoretext()
                elif rps_cpu == 'Paper':
                    print('You Win')
                    score = score + 1
                    wintext()
                    scoretext()

        if event.type == pygame.QUIT:
            run = False
            pygame.quit()
            quit()
