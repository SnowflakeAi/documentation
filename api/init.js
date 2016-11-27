window.onload = function () {
    var body = document.getElementsByTagName('body')[0];
    if (body) {
        console.log(body.className)
        body.className = body.className.replace("no-literate", "");
    }
};

Flatdoc.run({
    fetcher: Flatdoc.file([ './readme.md' ])
});
