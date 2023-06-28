package swing;

import java.awt.Color;
import java.awt.Graphics;
import java.util.Random;

public class Ball {
	public int x = 0;
	public int y = 0;
	public int vx = 0;
	public int vy = 0;
	public int speed = 4;
	public int radius = 10;

	public Ball(int screenWidth, int screenHeight) {
		reset(screenWidth, screenHeight);
	}

	public void reset(int screenWidth, int screenHeight) {
		x = screenWidth / 2;
		y = screenHeight / 2;
		speed = 4;

		if (vx < 0) {
			vx = speed;
		} else {
			vx = -speed;
		}

		bounce();
	}

	public void bounce() {
		Random rand = new Random();
		int choice = rand.nextInt(2);

		vy = choice == 0 ? -speed / 2 : speed / 2;
	}

	public void update(int screenWidth, int screenHeight) {
		x += vx;
		y += vy;
	}

	public void draw(Graphics g) {
		g.setColor(Color.WHITE);
		g.fillOval(x - radius, y - radius, radius * 2, radius * 2);
	}

	public Boolean outToLeft() {
		return x + radius < 0;
	}

	public Boolean outToRight(int screenWidth) {
		return x - radius > screenWidth;
	}
}
