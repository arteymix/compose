/* Copyright 2016 Guillaume Poirier-Morency <guillaumepoiriermorency@gmail.com>
 *
 * This file is part of Compose.
 *
 * Compose is free software: you can redistribute it and/or modify it under the
 * terms of the GNU Lesser General Public License as published by the Free
 * Software Foundation, either version 3 of the License, or (at your option) any
 * later version.
 *
 * Compose is distributed in the hope that it will be useful, but WITHOUT ANY
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
 * A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for more
 * details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with Compose.  If not, see <http://www.gnu.org/licenses/>.
 */

using Compose.HTML5;

public int main (string[] args)
{
	Test.init (ref args);

	Test.add_func ("/html5/element", () => {
		assert ("<tr&gt; a=\"\"\"><input/></tr&gt;>" == element ("tr>", {"a=\""}, "<input/>"));
		assert ("<tr&gt; a><input/></tr&gt;>" == element ("tr>", {"a"}, "<input/>"));
		assert ("<tr&gt; a></tr&gt;>" == element ("tr>", {"a"}));
	});

	return Test.run ();
}
