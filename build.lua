#!/usr/bin/env texlua

module = "darkmode"

typesetfiles  = {"*.tex"}

-- Shorten the tagging list
tagfiles = {"darkmode.dtx"}

-- Detail how to set the version automatically
function update_tag(file,content,tagname,tagdate)
    tagname = string.gsub(tagname, "^v", "")
    if string.match(file,"darkmode.dtx") then
        return string.gsub(content,
            "\n%%<package>\\ProvidesExplPackage %{darkmode%} %{[^}]+%} %{[^}]+%}\n",
            "\n%%<package>\\ProvidesExplPackage {darkmode} {" .. tagdate .. "} {" .. tagname .. "}\n"
        )
    end
end

function tag_hook(tagname)
  os.execute('git commit -a -m "Step release tag"')
  os.execute('git tag -a -m "" ' .. tagname)
end