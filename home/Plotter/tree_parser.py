import json

BEGIN_TAG = "---------- BEGIN JSON DUMP ----------"
END_TAG = "---------- END JSON DUMP ----------"

def get_tree_fragments(path):
    recording = False
    data = []

    with open(path) as fd:
        for line in fd.readlines():
            line = line.rstrip("\r\n")
            if line == BEGIN_TAG:
                recording = True
                data = []
            elif line == END_TAG:
                recording = False
                yield "\n".join(data)
            elif recording:
                data.append(line)

def get_trees(path):
    for fragment in get_tree_fragments(path):
        yield json.loads(fragment)
