import graphviz
import html


def plot_to_file(tree, out_path, out_format):
    tree_plot = TreePlot(tree)
    dot = tree_plot.get_dot()
    print(dot)
    dot.render(out_path, format=out_format)


def escape(text):
    text = html.escape(text)
    return text


class TreePlot:
    def __init__(self, tree):
        self._tree = tree

        self._dot = None
        self._global_index = 0

    def get_dot(self):
        if self._dot is None:
            self._dot = graphviz.Digraph()
            self._process_node(self._tree)

        return self._dot

    def _new_index(self):
        result = self._global_index
        self._global_index += 1
        return result

    def _new_node_name(self):
        return "node_{}".format(self._new_index())

    def _process_node(self, tree):
        node_class = tree.get("Class", "")
        node_constructor = tree.get("Constructor", "")

        node_id = self._new_node_name()

        children = []
        extra = []

        for key in tree:
            value = tree[key]
            if key in ("Class", "Constructor"):
                pass
            elif isinstance(value, list):
                children.extend((key, v) for v in value)
            elif isinstance(value, dict):
                children.append((key, value))
            else:
                extra.append(escape("{}: {}".format(key, value)))

        self._dot.node(name=node_id, label="{{{}|{}|{}}}".format(escape(node_class), escape(node_constructor), "\\n".join(extra)), shape="record")

        for role, child in children:
            child_id = self._process_node(child)
            self._dot.edge(node_id, child_id, label=escape(role))

        return node_id
