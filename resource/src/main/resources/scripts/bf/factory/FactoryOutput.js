define(["dojo/_base/declare","dojo/_base/connect","dijit/registry","dojo/dom-attr","dojo/dom-style","dojo/dom-class","bf/util"],
    function(declare,connect,registry,domAttr,domStyle,domClass) {
        return declare(null,
            {
                /**
                 *
                 * @param type
                 * @param node
                 */
                create:function(type, node){
                    var n = node;
                    var xfId = bf.util.getXfId(n);
                    var xfControlDijit = registry.byId(xfId);
                    // TODO: TBR: Lars: special handling for outputs within labels
                    var xfControlNode = xfControlDijit.domNode;
                    if(xfControlNode.parentNode.localName == "label"){
                        // console.debug("output is placed within label");
                        domStyle.set(xfControlNode, "display","inline");
                        domStyle.set(xfControlNode, "border",0);
                        domStyle.set(xfControlNode, "padding",0);
                    }

                    switch(type){

                        case "text":
                            // console.debug("FOUND .xfOutput.mediatypeText .xfValue ",n);
                            xfControlDijit.setCurrentValue(n.innerHTML);
                            xfControlDijit.setValue = function(value,schematype) {
                                // console.debug("xfControl.setValue: .xfOutput.mediatypeText .xfValue");
                                n.innerHTML = value;
                            };
                            connect.connect(n,"onblur",function(evt){
                                xfControlDijit.sendValue(n.innerHTML,true);
                            });

                            connect.connect(n,"onfocus",function(evt){
                                xfControlDijit.handleOnFocus();
                            });

                            break;
                        case "image":
                            // console.debug("FOUND .xfOutput.mediatypeImage .xfValue:",n);
                            xfControlDijit.setValue = function(value) {
                                domAttr.set(n, "src", value);
                            };
                            break;
                        case "link":
                            // console.debug("FOUND .xfOutput.xsdAnyURI .xfValue",n);
                            xfControlDijit.setCurrentValue(n.innerHTML);
                            connect.connect(n,"onblur",function(evt){
                                xfControlDijit.sendValue(n.innerHTML,true);
                            });

                            connect.connect(n,"onfocus",function(evt){
                                xfControlDijit.handleOnFocus();
                            });

                            //todo: this solution works in FF - others have to be tested
                            xfControlDijit.setReadonly = function(){
                                domClass.replace(n,"xfReadOnly","xfReadWrite");
                                domStyle.set(n, "pointerEvents","none");
                                domStyle.set(n, "cursor","default");
                            };

                            xfControlDijit.setReadwrite = function(){
                                domClass.replace(n,"xfReadWrite", "xfReadOnly");
                                domStyle.set(n, "pointerEvents","auto");
                                domStyle.set(n, "cursor","pointer");
                            };

                            xfControlDijit.setValue = function(value) {
                                // console.debug("xfControl.setValue: .xfOutput.xsdAnyURI .xfValue")
                                domAttr.set(n, "href", value);
                                n.innerHTML = value;
                            };
                            break;
                        case "html":
                            xfControlDijit.setValue = function(value) {
                                n.innerHTML = value;
                            };
                            break;
                        default:
                            console.warn("FactoryInput.default");

                    }
                }

            }
        );
    }
);

