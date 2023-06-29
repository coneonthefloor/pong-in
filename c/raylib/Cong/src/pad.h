#pragma once

#include <raylib.h>

typedef struct {
	int UpButton;
	int DownButton;
} InputScheme;

typedef struct {
	InputScheme Scheme;
	int Score;
	float Speed;

	Vector2 Position;
	int Width;
	int Height;
} Pad;