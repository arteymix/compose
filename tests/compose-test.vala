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

using Compose;

public int main (string[] args)
{
	Test.init (ref args);

	Test.add_func ("/when", () => {
		assert ("a" == when (true, () => { return "a"; }, () => { return "b"; }));
		assert ("b" == when (false, () => { return "a"; }, () => { return "b"; }));
	});

	Test.add_func ("/take", () => {
		string[] letters = {"a", "b", "c", "d", "e"};
		assert ("abcde" == take<string> ((i) => { return (i >= letters.length) ? null : letters[i]; },
		                                 (a) => { return a; }));
	});

	return Test.run ();
}
