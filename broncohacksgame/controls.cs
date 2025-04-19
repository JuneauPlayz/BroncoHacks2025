using Godot;
using System;
using System.IO.Ports;

public partial class Teensy1 : Node2D
{
	SerialPort serialPort;
	Node2D game;
	public override void _Ready()
	{
		game = GetParent<Node2D>();
		
		try
		{
			serialPort = new SerialPort("COM9", 9600);
			serialPort.ReadTimeout = 50;

			serialPort.Open();
		}
		catch (Exception e)
		{
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
				game.Set("h_state", states[0]);
				game.Set("v_state", states[1]);
	
				
			}
			else
			{
				game.Set("h_state", "");
				game.Set("v_state", "");
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
