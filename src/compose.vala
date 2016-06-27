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

/**
 * Functional templating for Vala.
 *
 * The following rules apply to determine a function signature:
 *
 * 1. mandatory attributes as parameters
 * 2. mandatory attributes with default values
 * 2. optional attributes as a null-terminated string array of 'key=value' entries
 * 3. mandatory children if appliable
 * 3. children as a varidic argument if appliable
 *
 * @since 1.0
 */
namespace Compose
{
	/**
	 * Evaluate something into a string.
	 *
	 * @since 1.0
	 */
	public delegate string EvaluateCallback ();

	/**
	 * Evaluate with a given generic argument.
	 *
	 * @since 1.0
	 */
	public delegate string EvaluateWithValueCallback<T> (T @value);

	/**
	 * Take an element from the source, possibly using the index.
	 *
	 * @since 1.0
	 *
	 * @param i if a counter is required to take elements from the source, this
	 *          one can be used
	 */
	public delegate T? TakeCallback<T> (int i);

	/**
	 * If the condition is met, evaluate the first callback, otherwise evaluate
	 * the second.
	 *
	 * @since 1.0
	 */
	public string when (bool condition, owned EvaluateCallback then, owned EvaluateCallback otherwise)
	{
		return condition ? then () : otherwise ();
	}

	/**
	 * Consume the first callback until it return 'null' and use the second one
	 * to evaluate each values into strings.
	 *
	 * @since 1.0
	 */
	public string take<T> (owned TakeCallback<T> c, owned EvaluateWithValueCallback<T> evaluate)
	{
		var builder = new StringBuilder ();
		int i       = 0;

		T   @value;
		while ((@value = c (i++)) != null)
		{
			builder.append (evaluate (@value));
		}

		return builder.str;
	}
}
