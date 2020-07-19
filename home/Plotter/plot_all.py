#!/usr/bin/env python3

import tree_parser
import tree_plotter

PATH = "../DumperPlugin2/out.log"

def main():
    for i, tree in enumerate(tree_parser.get_trees(PATH)):
        tree_plotter.plot_to_file(tree, out_path="out/{}".format(i), out_format="svg")


if __name__ == "__main__":
    main()
