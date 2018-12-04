defmodule Currency do
  def add({ad, ac}, {bd, bc}) do
    sum = {ad + bd, ac + bc}

    case sum do
      {d, c} when c > 100 ->
        add({d, 0}, simplify(c))

      s ->
        s
    end
  end

  defp simplify(cents) do
    d = rem(cents, 100)
    c = cents - d * 100
    {d, c}
  end
end
