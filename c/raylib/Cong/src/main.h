//
// Created by brian on 10/06/2023.
//

#include <raylib.h>
#include "pad.h"
#include "ball.h"


typedef struct {
    Pad player1;
    Pad player2;
    Ball ball;
} GameData;

void Loop(GameData* data);
void Update(GameData* data);
void Draw(GameData* data);
