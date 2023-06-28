package swing;

import java.awt.BasicStroke;
import java.awt.Color;
import java.awt.Font;
import java.awt.FontMetrics;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.Rectangle;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JPanel;
import javax.swing.Timer;

public class GamePanel extends JPanel implements ActionListener {
	private int WIDTH;
	private int HEIGHT;

	public Ball ball;
	public Paddle leftPaddle;
	public Paddle rightPaddle;

	public int width() {
		return (int) Math.floor(getSize().getWidth());
	}

	public int height() {
		return (int) Math.floor(getSize().getHeight());
	}

	public GamePanel(Pong pong, int width, int height) {
		setBackground(Color.BLACK);
		WIDTH = width;
		HEIGHT = height;
		ball = new Ball(WIDTH, HEIGHT);
		leftPaddle = new Paddle(20, HEIGHT);
		rightPaddle = new Paddle(WIDTH - 40, HEIGHT);

		Timer timer = new Timer(5, this);
		timer.start();
	}

	private void update() {
		leftPaddle.update(HEIGHT);
		rightPaddle.update(HEIGHT);

		ball.update(WIDTH, HEIGHT);

		if (ball.outToLeft()) {
			ball.reset(WIDTH, HEIGHT);
			rightPaddle.score += 1;
		}

		if (ball.outToRight(WIDTH)) {
			ball.reset(WIDTH, HEIGHT);
			leftPaddle.score += 1;
		}

		if (ball.y - ball.radius < 0) {
			ball.vy = ball.speed / 2;
		}

		if (ball.y + ball.radius * 2 > HEIGHT) {
			ball.vy = -ball.speed / 2;
		}

		if (ball.vx < 0) {
			leftPaddle.chaseBall(ball);
			rightPaddle.moveToCenter(HEIGHT);
		}

		if (ball.vx > 0) {
			rightPaddle.chaseBall(ball);
			leftPaddle.moveToCenter(HEIGHT);
		}

		if (leftPaddle.collidesWithBall(ball)) {
			ball.speed += 0.1;
			ball.vx = ball.speed;
			ball.bounce();
		}

		if (rightPaddle.collidesWithBall(ball)) {
			ball.speed += 0.1;
			ball.vx = -ball.speed;
			ball.bounce();
		}
	}

	@Override
	public void paintComponent(Graphics g) {
		super.paintComponent(g);
		drawDashedLineInCenter(g);

		Rectangle textBox = new Rectangle(0, 20, WIDTH, 50);
		Font font = new Font("monospace", 20, 20);
		String text = Integer.toString(leftPaddle.score) + "   " + Integer.toString(rightPaddle.score);
		drawCenteredString(g, text, textBox, font);
		ball.draw(g);
		leftPaddle.draw(g);
		rightPaddle.draw(g);
	}

	public void actionPerformed(ActionEvent e) {
		update();
		revalidate();
		repaint();
	}

	public void drawDashedLineInCenter(Graphics g) {
		Graphics2D g2d = (Graphics2D) g.create();
		g2d.setColor(Color.WHITE);
		BasicStroke dashed = new BasicStroke(1, BasicStroke.CAP_BUTT, BasicStroke.JOIN_BEVEL, 0, new float[] { 9 }, 0);
		g2d.setStroke(dashed);
		int halfWidth = WIDTH / 2;
		g2d.drawLine(halfWidth - 1, 0, halfWidth - 1, HEIGHT);
		g2d.dispose();
	}

	/**
	 * Draw a String centered in the middle of a Rectangle.
	 *
	 * @param g    The Graphics instance.
	 * @param text The String to draw.
	 * @param rect The Rectangle to center the text in.
	 */
	public void drawCenteredString(Graphics g, String text, Rectangle rect, Font font) {
		// Get the FontMetrics
		FontMetrics metrics = g.getFontMetrics(font);
		g.setColor(Color.WHITE);
		// Determine the X coordinate for the text
		int x = rect.x + (rect.width - metrics.stringWidth(text)) / 2;
		// Determine the Y coordinate for the text (note we add the ascent, as in java
		// 2d 0 is top of the screen)
		int y = rect.y + ((rect.height - metrics.getHeight()) / 2) + metrics.getAscent();
		// Set the font
		g.setFont(font);
		// Draw the String
		g.drawString(text, x, y);
	}
}
