
var metalang = {};
window.onload = function(){
    var err = 0;
      for (var i = 0; ; i++){
        var item = document.getElementById('exemple'+i);
        if (item == null){
            err ++;
            if (err == 5) break;
            break;
        }else{
            var d = document.createElement("div");
            d.innerHTML = caml_call_gen(metalang.colore, [item.value]);
            item.parentNode.replaceChild(d, item);
        }
      }
      for (var i = 0; ; i++){
        var item = document.getElementById('exemple_ml_'+i);
        if (item == null) break;
        var ed = CodeMirror.fromTextArea(item, {
          mode: 'text/x-ocaml',
        });
        ed.setOption("theme", "elegant");
      }
};
