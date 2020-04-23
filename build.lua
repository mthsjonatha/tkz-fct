-- Build script for tkz-fct

module = "tkz-fct"
tkzfctv = "1.3c"
tkzfctd = "2020/04/11"

-- Setting variables for .zip file (CTAN)
textfiles  = {"README.md"}
ctanreadme = "README.md"
ctanpkg    = module
ctanzip    = ctanpkg.."-"..tkzfctv
packtdszip = false
flatten    = false
cleanfiles = {ctanzip..".curlopt", ctanzip..".zip"}

-- Setting variables for package files
sourcefiledir = "latex"
docfiledir    = "doc"
docfiles      = {"TKZdoc-fct.pdf", "latex/*.tex"}
sourcefiles   = {"tkz-fct.sty"}
installfiles  = {"tkz-fct.sty"}

-- Setting file locations for local instalation (TDS)
tdslocations = {
  "doc/latex/tkz-fct/latex/TKZdoc-*.tex",
  "doc/latex/tkz-fct/TKZdoc-fct.pdf",
  "doc/latex/tkz-fct/README.md",
  "tex/latex/tkz-fct/tkz-fct.sty",
}

-- Update package date and version
tagfiles = {"./latex/tkz-fct.sty", "README.md", "doc/latex/TKZdoc-fct-main.tex"}

function update_tag(file, content, tagname, tagdate)
  if string.match(file, "%.tex$") then
    content = string.gsub(content,
                          "\\gdef\\tkzversionofpack{.-}",
                          "\\gdef\\tkzversionofpack{"..tkzfctv.."}")
    content = string.gsub(content,
                          "\\gdef\\tkzdateofpack{.-}",
                          "\\gdef\\tkzdateofpack{"..tkzfctd.."}")
    content = string.gsub(content,
                          "\\gdef\\tkzversionofdoc{.-}",
                          "\\gdef\\tkzversionofdoc{"..tkzfctv.."}")
    content = string.gsub(content,
                          "\\gdef\\tkzdateofdoc{.-}",
                          "\\gdef\\tkzdateofdoc{"..tkzfctd.."}")
  end
  if string.match(file, "%.sty$") then
    --local tkzfctv = "v"..tkzfctv
    content = string.gsub(content,
                          "\\ProvidesPackage{(.-)}%[%d%d%d%d%/%d%d%/%d%d %d+.%d+%a* (.-)%]",
                          "\\ProvidesPackage{%1}["..tkzfctd.." "..tkzfctv.." %2]")
    content = string.gsub(content,
                          "\\typeout{%d%d%d%d%/%d%d%/%d%d %d+.%d+%a* %s*(.-)}",
                          "\\typeout{"..tkzfctd.." "..tkzfctv.." %1}")
  end
  if string.match(file, "README.md$") then
    content = string.gsub(content,
                          "Release %d+.%d+%a* %d%d%d%d%/%d%d%/%d%d",
                          "Release "..tkzfctv.." "..tkzfctd)
  end
  return content
end

-- Typesetting package documentation
typesetfiles = {"TKZdoc-fct.tex"}

function docinit_hook()
  errorlevel = (cp("TKZdoc-fct-main.tex", "doc/latex", typesetdir)
              + ren(typesetdir, "TKZdoc-fct-main.tex", "TKZdoc-fct.tex"))
  if errorlevel ~= 0 then
    error("** Error!!: Can't rename TKZdoc-fct-main.tex to TKZdoc-fct.tex")
    return errorlevel
  end
  return 0
end

local function type_manual()
  local file = jobname(typesetdir.."/TKZdoc-fct.tex")
  errorlevel = (runcmd("lualatex --shell-escape "..file..".tex", typesetdir, {"TEXINPUTS","LUAINPUTS"})
              + runcmd("makeindex "..file..".idx", typesetdir, {"TEXINPUTS","LUAINPUTS"})
              + runcmd("lualatex --shell-escape "..file..".tex", typesetdir, {"TEXINPUTS","LUAINPUTS"}))
  if errorlevel ~= 0 then
    error("Error!!: Typesetting "..file..".tex")
    return errorlevel
  end
  return 0
end

specialtypesetting = { }
specialtypesetting["TKZdoc-fct.tex"] = {func = type_manual}

-- Load personal data
local ok, mydata = pcall(require, "Alaindata.lua")
if not ok then
  mydata = {email="XXX", uploader="YYY"}
end

-- CTAN upload config
uploadconfig = {
  author      = "Alain Matthes",
  uploader    = mydata.uploader,
  email       = mydata.email,
  pkg         = ctanpkg,
  version     = tkzfctv,
  license     = "lppl1.3c",
  summary     = "Tools for drawing graphs of functions",
  description = [[The tkz-fct package is designed to give math teachers (and students) easy access to programming graphs of functions with TikZ and gnuplot]],
  topic       = { "Graphics", "Graphics plot", "PGF TikZ" },
  ctanPath    = "/macros/latex/contrib/tkz/"..ctanpkg,
  repository  = "https://github.com/tkz-sty/"..ctanpkg,
  bugtracker  = "https://github.com/tkz-sty/"..ctanpkg.."/issues",
  support     = "https://github.com/tkz-sty/"..ctanpkg.."/issues",
  announcement_file="ctan.ann",
  note_file   = "ctan.note",
  update      = true,
}

-- Print lines in 80 characters
local function os_message(text)
  local mymax = 77 - string.len(text) - string.len("done")
  local msg = text.." "..string.rep(".", mymax).." done"
  return print(msg)
end

-- Create check_marked_tags() function
local function check_marked_tags()
  local f = assert(io.open("latex/tkz-fct.sty", "r"))
  marked_tags = f:read("*all")
  f:close()
  local m_pkgd, m_pkgv = string.match(marked_tags, "\\ProvidesPackage{tkz.-}%[(%d%d%d%d%/%d%d%/%d%d) (%d+.%d+%a*).-%]")
  if tkzfctv == m_pkgv and tkzfctd == m_pkgd then
    os_message("** Checking version and date: OK")
  else
    print("** Warning: tkz-fct.sty is marked with version "..m_pkgv.." and date "..m_pkgd)
    print("** Warning: build.lua is marked with version "..tkzfctv.." and date "..tkzfctd)
    print("** Check version and date in build.lua then run l3build tag")
  end
end

-- Config tag_hook
function tag_hook(tagname)
  check_marked_tags()
end

-- Add "tagged" target to l3build CLI
if options["target"] == "tagged" then
  check_marked_tags()
  os.exit()
end

-- GitHub release version
local function os_capture(cmd, raw)
  local f = assert(io.popen(cmd, 'r'))
  local s = assert(f:read('*a'))
  f:close()
  if raw then return s end
    s = string.gsub(s, '^%s+', '')
    s = string.gsub(s, '%s+$', '')
    s = string.gsub(s, '[\n\r]+', ' ')
  return s
end

local gitbranch = os_capture("git symbolic-ref --short HEAD")
local gitstatus = os_capture("git status --porcelain")
local tagongit  = os_capture('git for-each-ref refs/tags --sort=-taggerdate --format="%(refname:short)" --count=1')
local gitpush   = os_capture("git log --branches --not --remotes")

if options["target"] == "release" then
  if gitbranch == "master" then
    os_message("** Checking git branch '"..gitbranch.."': OK")
  else
    error("** Error!!: You must be on the 'master' branch")
  end
  if gitstatus == "" then
    os_message("** Checking status of the files: OK")
  else
    error("** Error!!: Files have been edited, please commit all changes")
  end
  if gitpush == "" then
    os_message("** Checking pending commits: OK")
  else
    error("** Error!!: There are pending commits, please run git push")
  end
  check_marked_tags()

  local pkgversion = "v"..tkzfctv
  local pkgdate = tkzfctd
  os_message("** Checking last tag marked in GitHub "..tagongit..": OK")
  errorlevel = os.execute("git tag -a "..pkgversion.." -m 'Release "..pkgversion.." "..pkgdate.."'")
  if errorlevel ~= 0 then
    error("** Error!!: tag "..tagongit.." already exists, run git tag -d "..pkgversion.." && git push --delete origin "..pkgversion)
    return errorlevel
  else
    os_message("** Running: git tag -a "..pkgversion.." -m 'Release "..pkgversion.." "..pkgdate.."'")
  end
  os_message("** Running: git push --tags --quiet")
  os.execute("git push --tags --quiet")
  if fileexists(ctanzip..".zip") then
    os_message("** Checking "..ctanzip..".zip file to send to CTAN: OK")
  else
    os_message("** Creating "..ctanzip..".zip file to send to CTAN")
    os.execute("l3build ctan > "..os_null)
  end
  os_message("** Running: l3build upload -F ctan.ann --debug")
  os.execute("l3build upload -F ctan.ann --debug >"..os_null)
  print("** Now check "..ctanzip..".curlopt file and add changes to ctan.ann")
  print("** If everything is OK run (manually): l3build upload -F ctan.ann")
  os.exit(0)
end
