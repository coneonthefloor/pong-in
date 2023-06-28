package swing;

import javax.swing.JFrame;

public class Pong extends JFrame {
	private final static int WIDTH = 640;
	private final static int HEIGHT = 480;

	public GamePanel panel;

	public Pong() {
		setSize(WIDTH, HEIGHT);
		setTitle("Pong");
		setResizable(false);
		setVisible(true);
		setDefaultCloseOperation(EXIT_ON_CLOSE);

		panel = new GamePanel(this, WIDTH, HEIGHT);
		add(panel);
	}
}
