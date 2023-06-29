#include "main.h"

const Vector2 INITIAL_BALL_VELOCITY = { .x = 100, .y = 50 };

void drawCenterLine() {
	int lineThickness = 2;
	float xCenter = GetScreenWidth() / 2;
	Vector2 start = { .x = xCenter, .y = 0 };
	Vector2 end = { .x = xCenter, .y = GetScreenHeight() };
	DrawLineEx(start, end, lineThickness, LIGHTGRAY);
}

void drawScore(Pad* p1, Pad* p2) {
	int textPad = 10;
	int fontSize = 20;

	const char* scoreLeft = TextFormat("%d", p1->Score);
	int scoreLeftSize = MeasureText(scoreLeft, fontSize);
	DrawText(scoreLeft, (GetScreenWidth() / 2) - textPad - scoreLeftSize, textPad, fontSize, LIGHTGRAY);

	const char* scoreRight = TextFormat("%d", p2->Score);
	DrawText(scoreRight, (GetScreenWidth() / 2) + textPad, textPad, fontSize, LIGHTGRAY);
}

GameData initializeGameData() {
	GameData data;

	int screenWidth = GetScreenWidth();
	int screenHeight = GetScreenHeight();

	int ballSize = 20;
	Vector2 ballPosition = { .x = screenWidth / 2, .y = screenHeight / 2 };
	Vector2 ballVelocity = INITIAL_BALL_VELOCITY;
	data.ball.Position = ballPosition;
	data.ball.Velocity = ballPosition;
	data.ball.Size = ballSize;

	int padWidth = 10;
	int padHeight = 100;
	int padXOffset = 20;
	int padSpeed = 220;

	InputScheme p1Input = { .UpButton = KEY_W, .DownButton = KEY_S };
	Vector2 p1Position = { .x = padXOffset, .y = screenHeight / 2 };
	data.player1.Position = p1Position;
	data.player1.Height = padHeight;
	data.player1.Width = padWidth;
	data.player1.Speed = padSpeed;
	data.player1.Score = 0;
	data.player1.Scheme = p1Input;

	InputScheme p2Input = { .UpButton = KEY_UP, .DownButton = KEY_DOWN };
	Vector2 p2Position = { .x = screenWidth - padXOffset - padWidth, .y = screenHeight / 2 };
	data.player2.Position = p2Position;
	data.player2.Height = padHeight;
	data.player2.Width = padWidth;
	data.player2.Speed = padSpeed;
	data.player2.Score = 0;
	data.player2.Scheme = p2Input;

	return data;
}

void Update(GameData* data) {
	UpdatePad(&data->player1);
	UpdatePad(&data->player2);
	UpdateBall(&data->ball);

	int screenWidth = GetScreenWidth();
	int screenHeight = GetScreenHeight();

	if (DetectBallTouchesPad(&data->ball, &data->player1) || DetectBallTouchesPad(&data->ball, &data->player2))
	{
		data->ball.Velocity.x *= -1;
	}

	if (data->ball.Position.y > screenHeight || data->ball.Position.y < 0)
	{
		data->ball.Velocity.y *= -1;
	}

	if (data->ball.Position.x > screenWidth)
	{
		data->player1.Score += 1;
		Vector2 ballPosition = { .x = screenWidth / 2, .y = screenHeight / 2 };
		data->ball.Position = ballPosition;
		data->ball.Velocity = INITIAL_BALL_VELOCITY;
	}

	if (data->ball.Position.x < 0)
	{
		data->player2.Score += 1;
		Vector2 ballPosition = { .x = screenWidth / 2, .y = screenHeight / 2 };
		data->ball.Position = ballPosition;
		data->ball.Velocity = INITIAL_BALL_VELOCITY;
	}
}

void Draw(GameData* data) {
	BeginDrawing();
	ClearBackground(BLACK);

	drawScore(&data->player1, &data->player2);
	drawCenterLine();

	DrawBall(&data->ball);
	DrawPad(&data->player1);
	DrawPad(&data->player2);

	EndDrawing();
}

void Loop(GameData* data) {
	while (!WindowShouldClose()) {
		Update(data);
		Draw(data);
	}
}

int main() {
	int screenWidth = 640;
	int screenHeight = 480;
	int targetFrameRate = 60;
	char windowTitle[] = "Cong";

	InitWindow(screenWidth, screenHeight, windowTitle);
	SetTargetFPS(targetFrameRate);

	GameData data = initializeGameData();
	Loop(&data);

	return 0;
}

