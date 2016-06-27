
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
