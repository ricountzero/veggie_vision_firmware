defmodule VeggieVision do
  @moduledoc """
  Using LM393 Soil Hygrometer Moisture Sensor, AO.
  Using Raspberry Pi Zero 2W with 0x2 address of pin, I2C protocol.
  Supervisor for managing I2C communication.
  Starts a task to open an I2C bus and read data continuously.
  """

  use Supervisor

  @i2c_address  0x2
  @protocl_name "i2c-1"

  @doc """
  Starts the supervisor and its child task.
  """
  def start_link(_) do
    Supervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  @doc """
  Initializes the supervisor with a child task to read I2C data.
  """
  def init(_) do
    children = [
      {Task, fn -> ready() end}
    ]
    Supervisor.init(children, strategy: :one_for_one)
  end

  @doc """
  Opens the I2C bus and starts reading data.
  Prints an error if the bus cannot be opened.
  """
  def ready() do
    case Circuits.I2C.open(@protocl_name) do
      {:ok, i2c_bus} ->
        measure(i2c_bus)
        Circuits.I2C.close(i2c_bus)
      {:error, reason} ->
        IO.puts("Failed to open I2C bus: #{reason}")
    end
  end

  @doc """
  Continuously reads data from the I2C bus with a delay.
  """
  def measure(i2c_bus, delay \\ 1000) do
    case Circuits.I2C.read(i2c_bus, @i2c_address, 2) do
      {:ok, <<_, data>>} ->
        IO.inspect(data)
      {:error, reason} ->
        IO.puts("Failed to read from I2C bus: #{reason}")
    end
    Process.sleep(delay)
    measure(i2c_bus, delay)
  end
end

VeggieVision.start_link([])
