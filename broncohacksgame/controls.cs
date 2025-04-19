using Godot;
using System;
using System.IO.Ports;

public partial class Teensy1 : Node2D
{
	SerialPort serialPort;
	RichTextLabel text;
	Node game;
	public override void _Ready()
	{
		game = GetNode<Node>(".");
		
		try
		{
			serialPort = new SerialPort("COM9", 9600);
			serialPort.ReadTimeout = 50;

			serialPort.Open();
			text.Text = "Serial Ready";
		}
		catch (Exception e)
		{
			text.Text = "Serial Error: " + e.Message;
			GD.PrintErr("Serial open error: " + e.Message);
		}
	}

	public override void _Process(double delta)
	{
		if (serialPort == null || !serialPort.IsOpen) return;
while (serialPort.BytesToRead > 0) 
	{
		try
		{
			string line = serialPort.ReadLine().Trim();
			string[] states = line.Split(',');

			if (states.Length >= 2)
			{
				string horizontalState = states[0];
				string verticalState = states[1];
	
				game.h_state = horizontalState;
				game.v_state = verticalState;
			}
			else
			{
				game.h_state = null;
				game.v_state = null;
			}
		}
		catch (TimeoutException)
		{
			// Nothing received this frame, ignore
		}
		catch (Exception e)
		{
			GD.PrintErr("Serial read error: " + e.Message);
		}
	}
	}
}
