vim-goiferr-snippets
====================

Installation
------------

vim-goiferr-snippets is a plugin that adds snippets that complement Go's return value. Support for UltiSnips and neosnippet.

### vim-plug

```
Plug 'nametake/vim-goiferr-snippets', {'for': 'go'}
```

Customize
---------

If you need, you can customize the last error of the iiferr to complement.

For UltiSnips, define your favorite snippet as follows.

```
snippet iferfav "Error return" b
if err != nil {
	`!v goiferrsnippets#goiferr('your_favorite_snippet_lib.Wrap(err, "${1}")}')`
}
${0}
endsnippet
```

Configuration
-------------

If you use neosnipet, you need to tell neosnippet the directory of vim-goiferr-snippet's snippet by adding the following configuration.

```vim
" Enable snipMate compatibility feature.
let g:neosnippet#enable_snipmate_compatibility = 1

" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory='your_plugin_install_directory/vim-iferr-snippets/snippets'
```
