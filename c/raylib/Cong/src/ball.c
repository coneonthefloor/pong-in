#include "ball.h"

void UpdateBall(Ball* ball) {
	ball->Position.x += GetFrameTime() * ball->Velocity.x;
	ball->Position.y += GetFrameTime() * ball->Velocity.y;
}

void DrawBall(Ball* ball) {
	float halfSize = ball->Size / 2.0f;
	DrawRectangle(ball->Position.x - halfSize, ball->Position.y - halfSize, ball->Size, ball->Size, WHITE);
}

bool DetectBallTouchesPad(Ball* ball, Pad* pad) {
	if (ball->Position.x >= pad->Position.x && ball->Position.x <= pad->Position.x + pad->Width)
	{
		if (ball->Position.y >= pad->Position.y - (pad->Height / 2) &&
			ball->Position.y <= pad->Position.y + (pad->Height / 2))
		{
			return true;
		}
	}

	return false;
}