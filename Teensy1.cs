using Godot;
using System;
using System.IO.Ports;

public partial class Teensy1 : Node2D
{
	SerialPort serialPort;
	RichTextLabel text;

	public override void _Ready()
	{
		text = GetNode<RichTextLabel>("RichTextLabel");

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

				text.Text = $"H: {horizontalState}\nV: {verticalState}";
			}
			else
			{
				text.Text = "Incomplete data: " + line;
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
