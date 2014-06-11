Description: This is a small example of how to use the toolbox to generate m2html documentation on projects written in Matlab.
To do the following procedure:
1. Download the m2html Toolbox from:
http://www.artefact.tk/software/matlab/m2html/m2html.zip
2. Download the Graphviz from:
http://www.graphviz.org/
3. Unpack m2html toolbox and add to setpath in Matlab
4. Install Graphviz
5. Copy the example in the m2html toolbox, and run this line:
m2html('mfiles','proyecto','htmldir','proyecto/docu','recursive','on','global','on','save','on','todo','on','template','blue','graph','on');
5. The documentation will created on a internal folder called docu.
Viel glueck....

返回上一级目录：

运行：
m2html('mfiles','proyecto','htmldir','proyecto/docu','recursive','on','global','on','save','on','todo','on','template','blue','graph','on'); 

即可生成文档。


m2html('mfiles','Analysis','htmldir','Analysis/docu','recursive','on','global','on','save','on','todo','on','template','blue','graph','on'); 