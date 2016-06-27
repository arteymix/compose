[CCode (cname = "htmlEncodeEntities")]
private extern int html_encode_entities ([CCode (array_length = false)] char[] outbuf, ref int outbuf_len, [CCode (array_length = false)] char[] inbuf, ref int inbuf_len, char quote_char = '\0');

/**
 * @since 1.0
 */
namespace Compose.HTML5
{
	private string encode_entities (string inbuf)
	{
		char[] encoded     = new char[inbuf.length * 4];
		int    encoded_len = inbuf.length * 4;
		int    inbuf_len   = inbuf.length;
		if (html_encode_entities (encoded, ref encoded_len, inbuf.to_utf8 (), ref inbuf_len) == 0)
		{
			encoded[encoded_len] = '\0';
			return (string) encoded;
		}
		else
		{
			warning ("Could not encode '%s' using 'htmlEncodeEntities'.", inbuf);
			return "";
		}
	}

	private string elementv (string tag, string[] attributes, va_list children)
	{
		var el = new StringBuilder ();

		el.append_printf ("<%s", encode_entities (tag));

		foreach (var attribute in attributes)
		{
			var name = attribute.slice (0, attribute.index_of_char ('=') > -1 ? attribute.index_of_char ('=') : attribute.length);
			el.append_printf (" %s", encode_entities (name));

			if (attribute.index_of_char ('=') > -1)
			{
				var @value = attribute.slice (attribute.index_of_char ('=') + 1, attribute.length);
				el.append_printf ("=\"%s\"", @value.length > 0 ? encode_entities (@value) : "");
			}
		}

		var child = children.arg<string> ();

		if (child == null)
		{
			// TODO: check for auto-closing tags (e.g. '<img>', '<input>')
			el.append ("/>");
		}
		else
		{
			el.append_c ('>');

			for (; child != null; child = children.arg<string> ())
			{
				el.append (child);
			}

			el.append_printf ("</%s>", encode_entities (tag));
		}

		return el.str;
	}

	public string element (string tag, string[] attributes, ...)
	{
		return elementv (tag, attributes, va_list ());
	}

	public string a (string href, string[] attributes = {}, ...)
	{
		Environ.set_variable (attributes, "href", href, true);
		return elementv ("a", attributes, va_list ());
	}

	public string abbr       (string[] attributes = {}, ...) { return elementv ("abbr",       attributes, va_list ()); }
	public string address    (string[] attributes = {}, ...) { return elementv ("address",    attributes, va_list ()); }
	public string area       (string[] attributes = {}, ...) { return elementv ("area",       attributes, va_list ()); }
	public string article    (string[] attributes = {}, ...) { return elementv ("article",    attributes, va_list ()); }
	public string aside      (string[] attributes = {}, ...) { return elementv ("aside",      attributes, va_list ()); }
	public string audio      (string[] attributes = {}, ...) { return elementv ("audio",      attributes, va_list ()); }
	public string b          (string[] attributes = {}, ...) { return elementv ("b",          attributes, va_list ()); }
	public string @base      (string[] attributes = {}, ...) { return elementv ("base",       attributes, va_list ()); }
	public string bdi        (string[] attributes = {}, ...) { return elementv ("bdi",        attributes, va_list ()); }
	public string bdo        (string[] attributes = {}, ...) { return elementv ("bdo",        attributes, va_list ()); }
	public string blockquote (string[] attributes = {}, ...) { return elementv ("blockquote", attributes, va_list ()); }
	public string body       (string[] attributes = {}, ...) { return elementv ("body ",      attributes, va_list ()); }

	public string br (string[] attributes = {})
	{
		return element ("br", attributes);
	}

	public string button (string name, string content = "", string[] attributes = {})
	{
		Environ.set_variable (attributes, "name", name, true);
		return element ("button", attributes, encode_entities (content));
	}

	public string canvas   (string[] attributes = {}, ...) { return elementv ("canvas",   attributes, va_list ()); }
	public string caption  (string[] attributes = {}, ...) { return elementv ("caption",  attributes, va_list ()); }
	public string cite     (string[] attributes = {}, ...) { return elementv ("cite",     attributes, va_list ()); }
	public string code     (string[] attributes = {}, ...) { return elementv ("code",     attributes, va_list ()); }
	public string col      (string[] attributes = {}, ...) { return elementv ("col",      attributes, va_list ()); }
	public string colgroup (string[] attributes = {}, ...) { return elementv ("colgroup", attributes, va_list ()); }

	public string command (string[] attributes = {})
	{
		return element ("command ", attributes);
	}

	public string datalist (string[] attributes = {}, ...) { return elementv ("datalist", attributes, va_list ()); }
	public string dd       (string[] attributes = {}, ...) { return elementv ("dd",       attributes, va_list ()); }
	public string del      (string[] attributes = {}, ...) { return elementv ("del",      attributes, va_list ()); }
	public string details  (string[] attributes = {}, ...) { return elementv ("details",  attributes, va_list ()); }
	public string dfn      (string[] attributes = {}, ...) { return elementv ("dfn",      attributes, va_list ()); }
	public string div      (string[] attributes = {}, ...) { return elementv ("div",      attributes, va_list ()); }
	public string dl       (string[] attributes = {}, ...) { return elementv ("dl",       attributes, va_list ()); }
	public string dt       (string[] attributes = {}, ...) { return elementv ("dt",       attributes, va_list ()); }
	public string em       (string[] attributes = {}, ...) { return elementv ("em",       attributes, va_list ()); }

	public string embed (string src, string[] attributes = {})
	{
		Environ.set_variable (attributes, "src", src);
		return element ("embed", attributes);
	}

	public string fieldset   (string[] attributes = {}, ...) { return elementv ("fieldset",   attributes, va_list ()); }
	public string figcaption (string[] attributes = {}, ...) { return elementv ("figcaption", attributes, va_list ()); }
	public string figure     (string[] attributes = {}, ...) { return elementv ("figure",     attributes, va_list ()); }
	public string footer     (string[] attributes = {}, ...) { return elementv ("footer",     attributes, va_list ()); }
	public string form       (string[] attributes = {}, ...) { return elementv ("form",       attributes, va_list ()); }
	public string h1         (string[] attributes = {}, ...) { return elementv ("h1",         attributes, va_list ()); }
	public string h2         (string[] attributes = {}, ...) { return elementv ("h2",         attributes, va_list ()); }
	public string h3         (string[] attributes = {}, ...) { return elementv ("h3",         attributes, va_list ()); }
	public string h4         (string[] attributes = {}, ...) { return elementv ("h4",         attributes, va_list ()); }
	public string h5         (string[] attributes = {}, ...) { return elementv ("h5",         attributes, va_list ()); }
	public string h6         (string[] attributes = {}, ...) { return elementv ("h6",         attributes, va_list ()); }
	public string head       (string[] attributes = {}, ...) { return elementv ("head",       attributes, va_list ()); }
	public string header     (string[] attributes = {}, ...) { return elementv ("header",     attributes, va_list ()); }
	public string hgroup     (string[] attributes = {}, ...) { return elementv ("hgroup",     attributes, va_list ()); }
	public string hr         (string[] attributes = {}, ...) { return elementv ("hr",         attributes, va_list ()); }

	public string html (string[] attributes, ...)
	{
		return "<!DOCTYPE html>%s".printf (elementv ("html", attributes, va_list ()));
	}

	public string i      (string[] attributes = {}, ...) { return elementv ("i",      attributes, va_list ()); }
	public string iframe (string[] attributes = {}, ...) { return elementv ("iframe", attributes, va_list ()); }

	public string img (string src, string[] attributes = {})
	{
		Environ.set_variable (attributes, "src", src, true);
		return element ("img", attributes);
	}

	public string input (string name, string? @value = null, string[] attributes = {})
	{
		Environ.set_variable (attributes, "name",  name,   true);
		if (@value != null)
		{
			Environ.set_variable (attributes, "value", @value, true);
		}
		return element ("input", attributes);
	}

	public string ins    (string[] attributes = {}, ...) { return elementv ("ins",    attributes, va_list ()); }
	public string kdb    (string[] attributes = {}, ...) { return elementv ("kdb",    attributes, va_list ()); }
	public string keygen (string[] attributes = {}, ...) { return elementv ("keygen", attributes, va_list ()); }

	public string label (string @for, string[] attributes = {}, ...)
	{
		Environ.set_variable (attributes, "for", @for, true);
		return elementv ("label",  attributes, va_list ());
	}

	public string link (string href, string rel = "stylesheet", string[] attributes = {}, ...)
	{
		Environ.set_variable (attributes, "href", href, true);
		Environ.set_variable (attributes, "rel",  rel,  true);
		return elementv ("link", attributes, va_list ());
	}

	public string main (string[] attributes = {}, ...) { return elementv ("main", attributes, va_list ()); }
	public string map  (string[] attributes = {}, ...) { return elementv ("map",  attributes, va_list ()); }
	public string mark (string[] attributes = {}, ...) { return elementv ("mark", attributes, va_list ()); }
	public string menu (string[] attributes = {}, ...) { return elementv ("menu", attributes, va_list ()); }

	public string meta (string[] attributes = {})
	{
		return element ("meta", attributes);
	}

	public string meter    (string[] attributes = {}, ...) { return elementv ("meter",    attributes, va_list ()); }
	public string nav      (string[] attributes = {}, ...) { return elementv ("nav",      attributes, va_list ()); }
	public string noscript (string[] attributes = {}, ...) { return elementv ("noscript", attributes, va_list ()); }
	public string object   (string[] attributes = {}, ...) { return elementv ("object",   attributes, va_list ()); }
	public string ol       (string[] attributes = {}, ...) { return elementv ("ol",       attributes, va_list ()); }
	public string optgroup (string[] attributes = {}, ...) { return elementv ("optgroup", attributes, va_list ()); }

	public string option (string @value, string? content = null, string[] attributes = {})
	{
		Environ.set_variable (attributes, "value", @value, true);
		return element ("option", attributes, encode_entities (content ?? @value));
	}

	public string output (string name, string[] attributes = {}, ...)
	{
		Environ.set_variable (attributes, "name", name, true);
		return elementv ("output",  attributes, va_list ());
	}

	public string p (string[] attributes = {}, ...) { return elementv ("p", attributes, va_list ()); }

	public string param (string name, string @value, string[] attributes = {})
	{
		Environ.set_variable (attributes, "name",  name,   true);
		Environ.set_variable (attributes, "value", @value, true);
		return element ("param", attributes);
	}

	public string pre (string content, string[] attributes = {})
	{
		return element ("pre", attributes, encode_entities (content));
	}

	public string progress (string[] attributes = {}, ...) { return elementv ("progress", attributes, va_list ()); }
	public string q        (string[] attributes = {}, ...) { return elementv ("q",        attributes, va_list ()); }
	public string rp       (string[] attributes = {}, ...) { return elementv ("rp",       attributes, va_list ()); }
	public string rt       (string[] attributes = {}, ...) { return elementv ("rt",       attributes, va_list ()); }
	public string ruby     (string[] attributes = {}, ...) { return elementv ("ruby",     attributes, va_list ()); }
	public string s        (string[] attributes = {}, ...) { return elementv ("s",        attributes, va_list ()); }
	public string samp     (string[] attributes = {}, ...) { return elementv ("samp",     attributes, va_list ()); }
	public string script   (string[] attributes = {}, ...) { return elementv ("script",   attributes, va_list ()); }
	public string section  (string[] attributes = {}, ...) { return elementv ("section",  attributes, va_list ()); }

	public string select (string name, string[] attributes = {}, ...)
	{
		Environ.set_variable (attributes, "name", name, true);
		return elementv ("select", attributes, va_list ());
	}

	public string small (string[] attributes = {}, ...) { return elementv ("small", attributes, va_list ()); }

	public string source (string src, string[] attributes = {})
	{
		Environ.set_variable (attributes, "src", src, true);
		return element ("source", attributes);
	}

	public string span   (string[] attributes = {}, ...) { return elementv ("span",   attributes, va_list ()); }
	public string strong (string[] attributes = {}, ...) { return elementv ("strong", attributes, va_list ()); }

	public string style (string content, string[] attributes = {})
	{
		return element ("style", attributes, encode_entities (content));
	}

	public string sub     (string[] attributes = {}, ...) { return elementv ("sub",     attributes, va_list ()); }
	public string summary (string[] attributes = {}, ...) { return elementv ("summary", attributes, va_list ()); }
	public string sup     (string[] attributes = {}, ...) { return elementv ("sup",     attributes, va_list ()); }
	public string table   (string[] attributes = {}, ...) { return elementv ("table",   attributes, va_list ()); }
	public string tbody   (string[] attributes = {}, ...) { return elementv ("tbody",   attributes, va_list ()); }
	public string td      (string[] attributes = {}, ...) { return elementv ("td",      attributes, va_list ()); }

	public string textarea (string name, string @value = "", string[] attributes = {})
	{
		Environ.set_variable (attributes, "name", name, true);
		return element ("textarea", attributes, encode_entities (@value));
	}

	public string tfoot (string[] attributes = {}, ...) { return elementv ("tfoot", attributes, va_list ()); }
	public string th    (string[] attributes = {}, ...) { return elementv ("th",    attributes, va_list ()); }
	public string thead (string[] attributes = {}, ...) { return elementv ("thead", attributes, va_list ()); }
	public string time  (string[] attributes = {}, ...) { return elementv ("time",  attributes, va_list ()); }

	public string title (string content, string[] attributes = {})
	{
		return element ("title", attributes, content);
	}

	public string tr (string[] attributes = {}, ...) { return elementv ("tr", attributes, va_list ()); }

	public string track (string src, string[] attributes = {})
	{
		Environ.set_variable (attributes, "src", src, true);
		return element ("track", attributes);
	}

	public string u     (string[] attributes = {}, ...) { return elementv ("u",     attributes, va_list ()); }
	public string ul    (string[] attributes = {}, ...) { return elementv ("ul",    attributes, va_list ()); }
	public string @var  (string[] attributes = {}, ...) { return elementv ("var",   attributes, va_list ()); }
	public string video (string[] attributes = {}, ...) { return elementv ("video", attributes, va_list ()); }

	public string wbr (string[] attributes = {})
	{
		return element ("wbr", attributes);
	}
}
