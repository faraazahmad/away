defmodule Away do
  @moduledoc """
    
    Away: An Elixir library to return time ago or time remaining
    until a given timestamp. The given timestamp can be in UTC 
    time format or Elixir\'s 'Time' struct.

  """

  @doc """
    This function takes a `Time` struct as parameter, and then
    converts it to an Erlang time tuple, i.e. {hours, minutes, seconds}

    The current time is then compared with these hours, minutes and seconds,
    and the if the difference is zero, the smaller time unit is used to 
    display time ago.
  """
  def ago_in_words(utc_time) do
    {hour, minute, second} = Time.to_erl(utc_time)
    {current_hour, current_minute, current_second} = Time.to_erl(Time.utc_now)

    if hour == current_hour do
      if minute == current_minute do
        if second == current_second do
          "Just now"
        else
          ago(current_second - second, simply_pluralise(current_second - second, :second))
        end
      else
        ago(current_minute - minute, simply_pluralise(current_minute - minute, :minute))
      end
    else
      ago(current_hour - hour, simply_pluralise(current_hour - hour, :hour))
    end
  end

  @doc """
    A private helper function to return the string like this
    
    ago(5, :hours)
      => "5 hours ago"
  """
  defp ago(difference, time_unit), do: "#{difference} #{time_unit} ago"


  @doc """
    A private helper function to simply pluralise a word by appending \'s\'
    to the word.
  """
  defp simply_pluralise(quantity, word) do
    if quantity == 1 do
      word
    else
      "#{word}s"
    end  
  end 
end
