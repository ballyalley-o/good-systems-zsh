
function mkdir
{
    command mkdir $1 && cd $1
}

function gitn
{
    git log --oneline --abbrev-commit --all --graph --decorate --color -n 5
}