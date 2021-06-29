# vim-goiferr-snippets

vim-goiferr-snippets is a plugin that adds snippets that complement Go's return value. Support for UltiSnips and neosnippet.

[![asciicast](https://asciinema.org/a/422940.svg)](https://asciinema.org/a/422940)

## Installation

### vim-plug

```vim
Plug 'nametake/vim-goiferr-snippets', {'for': 'go'}
```

## Customize

If you need, you can customize the last error of the iiferr to complement.

For UltiSnips, define your favorite snippet as follows.

```snippets
snippet iferfav "Error return" b
if err != nil {
	`!v goiferrsnippets#ReturnValueWithoutError()`, your_favorite_snippet_lib.Wrap(err, "${1}")
}
${0}
endsnippet
```

## Configuration

If you use neosnipet, you need to tell neosnippet the directory of vim-goiferr-snippet's snippet by adding the following configuration.

```vim
" Enable snipMate compatibility feature.
let g:neosnippet#enable_snipmate_compatibility = 1

" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory='your_plugin_install_directory/vim-iferr-snippets/snippets'
```

## Special thanks

[@pocke](https://github.com/pocke) ([Vim で Go 言語を書いている時、Neosnippet でいい感じに if する](https://pocke.hatenablog.com/entry/2015/12/20/133445))
