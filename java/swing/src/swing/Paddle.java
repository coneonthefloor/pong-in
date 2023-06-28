package swing;

import java.awt.Color;
import java.awt.Graphics;

public class Paddle {
	public int x = 0;
	public int y = 0;
	public int vx = 0;
	public int vy = 0;
	public int width = 10;
	public int height = 100;
	public int speed = 4;
	public int score = 0;

	public Paddle(int offsetX, int screenHeight) {
		x = offsetX;
		y = screenHeight / 2 - height / 2;
	}

	public void draw(Graphics g) {
		g.setColor(Color.WHITE);
		g.fillRect(x, y, width, height);
	}

	public void update(int screenHeight) {
		x += vx;
		y += vy;

		if (y < 0) {
			y = 0;
		}

		if (y + height >= screenHeight) {
			y = screenHeight - height;
		}
	}

	public void chaseBall(Ball ball) {
		moveToTargetY(ball.y - height / 2);
	}

	public void moveToCenter(int screenHeight) {
		moveToTargetY(screenHeight / 2 - height / 2);
	}

	public void moveToTargetY(int targetY) {
		int toVectorY = targetY - y;

		int sqDist = toVectorY * toVectorY;

		if (sqDist == 0 || (speed >= 0 && sqDist <= speed * speed)) {
			return;
		}

		double dist = Math.sqrt(sqDist);
		double newY = y + (toVectorY / dist) * speed;

		y = (int) newY;
	}

	public Boolean collidesWithBall(Ball ball) {
		return (ball.x > x && ball.x < x + width && ball.y > y && ball.y < y + height);
	}
}
