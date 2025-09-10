import 'package:almonazim/data/model/account%20models/account_model.dart';
import 'package:animated_tree_view/tree_view/tree_node.dart';

void prepareRevenueTreeNode(data, TreeNode<dynamic> treeNode) {
  List<TreeNode> allNodes = [];

  for (final account in data) {
    AccountModel accountModel = AccountModel.fromJson(account);
    if (accountModel.accountsCode!.startsWith("4")) {
      allNodes.add(TreeNode(
        key: accountModel.accountsCode,
        data: accountModel,
      ));
    }
  } // Filter level 1 nodes
  List<TreeNode> level1Nodes = allNodes
      .where((node) => (node.data as AccountModel).accountsLevel == 1)
      .toList();
  // Add level 1 nodes to the tree
  treeNode.addAll(level1Nodes);

  // Loop through level 1 nodes to add children
  for (final nodeLevel1 in level1Nodes) {
    // Filter level 2 nodes for this level 1 node
    List<TreeNode> level2Nodes = allNodes.where((node) {
      final data = node.data as AccountModel;
      return data.accountsLevel == 2 &&
          data.accountsParentId == nodeLevel1.data.accountsId;
    }).toList();

    // Add level 2 nodes as children to the level 1 node
    nodeLevel1.addAll(level2Nodes);

    // Loop through level 2 nodes to add children
    for (final nodeLevel2 in level2Nodes) {
      // Filter level 3 nodes for this level 2 node
      List<TreeNode> level3Nodes = allNodes.where((node) {
        final data = node.data as AccountModel;
        return data.accountsLevel == 3 &&
            data.accountsParentId == nodeLevel2.data.accountsId;
      }).toList();

      // Add level 3 nodes as children to the level 2 node
      nodeLevel2.addAll(level3Nodes);

      // Loop through level 3 nodes to add children
      for (final nodeLevel3 in level3Nodes) {
        // Filter level 4 nodes for this level 3 node
        List<TreeNode> level4Nodes = allNodes.where((node) {
          final data = node.data as AccountModel;
          return data.accountsLevel == 4 &&
              data.accountsParentId == nodeLevel3.data.accountsId;
        }).toList();

        // Add level 4 nodes as children to the level 3 node
        nodeLevel3.addAll(level4Nodes);
      }
    }
  }
}
