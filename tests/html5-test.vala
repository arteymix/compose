using Compose.HTML5;

public int main (string[] args)
{
	Test.init (ref args);

	Test.add_func ("/html5/element", () => {
		assert ("<tr&gt; a=\"\"\"><input/></tr&gt;>" == element ("tr>", {"a=\""}, "<input/>"));
		assert ("<tr&gt; a><input/></tr&gt;>" == element ("tr>", {"a"}, "<input/>"));
		assert ("<tr&gt; a/>" == element ("tr>", {"a"}));
	});

	return Test.run ();
}
