const pages = require.context('.', true, /_page\.js$/)
pages.keys().forEach(pages)
