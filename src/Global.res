@val external importMetaUrl: Url.t = "import.meta.url"
let filename: Url.t => string = m => Url.fileURLToPath(m)
let dirname: Url.t => string = m => Path.dirname(filename(m))
@val external global: {..} = "global"
@val external import: string => Promise.t<{..}> = "import"
