# DelirimTremex - standardised GraphQL error handling through Absinthe
# Copyright (C) 2018 FloatingPoint.io
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

defmodule DeliriumTremex.Middleware.HandleErrors do
  @behaviour Absinthe.Middleware

  alias Absinthe.Resolution

  def call(%{errors: errors} = resolution, _config) when is_list(errors) do
    Resolution.put_result(resolution, {:error, format_errors(errors)})
  end

  def call(resolution, _config) do
    resolution
  end

  defp format_errors(errors) do
    Enum.flat_map(errors, &format_error/1)
  end

  defp format_error(%Ecto.Changeset{} = changeset) do
    changeset
      |> Ecto.Changeset.traverse_errors(fn error -> error end)
      |> Enum.map(
        &DeliriumTremex.Formatters.Ecto.Changeset.format/1
      )
  end

  defp format_error(error) when is_map(error) do
    DeliriumTremex.Formatters.Map.format(error)
  end
end
