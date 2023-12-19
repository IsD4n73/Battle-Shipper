import 'dart:io';

void main(List<String> args) async {
  // help command
  if (args.contains("--help") || args.contains("-h") || args.isEmpty) {
    print("Usage: \n\n"
        "--help (or -h) --> show this message \n\n"
        "--dir [path] --> give the project directory \n"
        "--feature (or -f) [name] --> Create new feature with given name \n"
        "--layer (or -l) [name] --> create new layer with given name \n\n"
        "if you want to create the .gitkeep files within each folder add --gitkeep to the end of the command \n"
        "if you want to remove the control over the path add --force-dir to the end of the command \n");

    return;
  }

  //get the directory
  String path = "";
  bool forcePath = false;
  if (args.contains("--force-dir")) {
    forcePath = true;
  }

  if (args.contains("--dir")) {
    path = args[args.indexOf("--dir") + 1];
    print("project directory set to: $path \n");
    if (!path.contains("lib") && !forcePath) {
      print(
          "in the selected pat the lib folder was not found, if you want to continue run the command with --force-dir at the end \n");
    }
  } else {
    print("project folder not found, specify with --dir [path] \n");
    return;
  }

  // gitkeep
  bool addgitkeep = false;
  if (args.contains("--gitkeep")) {
    print(".gitkeep files will be added to each folder \n");
    addgitkeep = true;
  }

  // feature command
  if (args.contains("--feature")) {
    await createFeature(path, args[args.indexOf("--feature") + 1], addgitkeep);
    return;
  }
  if (args.contains("-f")) {
    await createFeature(path, args[args.indexOf("-f") + 1], addgitkeep);
    return;
  }

  // layer command
  if (args.contains("--layer")) {
    await createlayer(path, args[args.indexOf("--layer") + 1], addgitkeep);
    return;
  }
  if (args.contains("-l")) {
    await createlayer(path, args[args.indexOf("-l") + 1], addgitkeep);
    return;
  }
}

Future<void> createFeature(String path, String name, bool keep) async {
  await createlayer("$path/$name", "data", keep);
  await createlayer("$path/$name", "domain", keep);
  await createlayer("$path/$name", "presenter", keep);
}

Future<void> createlayer(String path, String layer, bool keep) async {
  if (layer != "data" && layer != "presenter" && layer != "domain") {
    print("the accepted layers are: data, domain, presenter \n");
    return;
  }

  if (keep) {
    switch (layer) {
      case "data":
        await File('$path/data/datasource/.gitkeep').create(recursive: true);
        await File('$path/data/models/.gitkeep').create(recursive: true);
        await File('$path/data/repositories/.gitkeep').create(recursive: true);
        await File('$path/data/services/.gitkeep').create(recursive: true);
        print("All file created for data \n");
        break;
      case "domain":
        await File('$path/domain/entities/.gitkeep').create(recursive: true);
        await File('$path/domain/repositories/.gitkeep')
            .create(recursive: true);
        await File('$path/domain/services/.gitkeep').create(recursive: true);
        await File('$path/domain/stores/.gitkeep').create(recursive: true);
        await File('$path/domain/usecase/.gitkeep').create(recursive: true);
        print("All file created for domain \n");
        break;
      case "presenter":
        await File('$path/presenter/cubit/.gitkeep').create(recursive: true);
        await File('$path/presenter/pages/.gitkeep').create(recursive: true);
        await File('$path/presenter/widgets/.gitkeep').create(recursive: true);
        print("All file created for presenter \n");
        break;
    }
  } else {
    switch (layer) {
      case "data":
        await Directory('$path/data/datasource').create(recursive: true);
        await Directory('$path/data/models').create(recursive: true);
        await Directory('$path/data/repositories').create(recursive: true);
        await Directory('$path/data/services').create(recursive: true);
        print("All file created for data \n");
        break;
      case "domain":
        await Directory('$path/domain/entities').create(recursive: true);
        await Directory('$path/domain/repositories').create(recursive: true);
        await Directory('$path/domain/services').create(recursive: true);
        await Directory('$path/domain/stores').create(recursive: true);
        await Directory('$path/domain/usecase').create(recursive: true);
        print("All file created for domain \n");
        break;
      case "presenter":
        await Directory('$path/presenter/cubit').create(recursive: true);
        await Directory('$path/presenter/pages').create(recursive: true);
        await Directory('$path/presenter/widgets').create(recursive: true);
        print("All file created for presenter \n");
        break;
    }
  }
}
