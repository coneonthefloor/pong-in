#include <raylib.h>
#include "pad.h"

void DrawPad(Pad* pad) {
	DrawRectangle(pad->Position.x, pad->Position.y - (pad->Height / 2), pad->Width, pad->Height, WHITE);
}

void UpdatePad(Pad* pad) {
	if (IsKeyDown(pad->Scheme.UpButton)) {
		pad->Position.y -= GetFrameTime() * pad->Speed;
	}

	if (IsKeyDown(pad->Scheme.DownButton)) {
		pad->Position.y += GetFrameTime() * pad->Speed;
	}

	if (pad->Position.y - (pad->Height / 2) < 0) {
		pad->Position.y = pad->Height / 2;
	}

	if (pad->Position.y + (pad->Height / 2) > GetScreenHeight()) {
		pad->Position.y = GetScreenHeight() - (pad->Height / 2);
	}
}