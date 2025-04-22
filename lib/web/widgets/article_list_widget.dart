import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tatu_frontend/web/providers/article_provider.dart';
import 'package:tatu_frontend/web/providers/auth_provider.dart';

class ArticleListWidget extends StatelessWidget {
  const ArticleListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final articleProvider = Provider.of<ArticleProvider>(context);

    return articleProvider.articles.isEmpty
        ? Center(
          child: Text(
            'No articles available.',
            style: TextStyle(fontSize: 16.0, color: Colors.grey),
          ),
        )
        : Expanded(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton<String>(
                  hint: Text('Filter by School Year'),
                  value: articleProvider.selectedSchoolYear,
                  items:
                      articleProvider.schoolYears.map((year) {
                        return DropdownMenuItem<String>(
                          value: year.name,
                          child: Text(year.name),
                        );
                      }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      articleProvider.filterBySchoolYear(value);
                    }
                  },
                ),
              ),
              Row(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: [
                          DataColumn(label: Text('Title')),
                          DataColumn(label: Text('School Year')),
                          DataColumn(label: Text('Professor')),
                          DataColumn(label: Text('Created At')),
                          DataColumn(label: Text('Actions')),
                        ],
                        rows:
                            articleProvider.articles.map((article) {
                              return DataRow(
                                cells: [
                                  DataCell(Text(article.title)),
                                  DataCell(
                                    Text(
                                      '${DateFormat('yyyy').format(article.schoolYear.startDate)}/${DateFormat('yyyy').format(article.schoolYear.endDate)}',
                                    ),
                                  ),
                                  DataCell(Text(article.professor.username)),
                                  DataCell(
                                    Text(
                                      DateFormat(
                                        'yyyy-MM-dd HH:mm',
                                      ).format(article.createdAt),
                                    ),
                                  ),
                                  DataCell(
                                    Consumer<AuthProvider>(
                                      builder: (ctx, authProvider, _) {
                                        return authProvider.isProfessor
                                            ? Row(
                                              children: [
                                                IconButton(
                                                  icon: Icon(
                                                    Icons.visibility,
                                                    color: Colors.blue,
                                                  ),
                                                  onPressed: () {
                                                    // Handle view article
                                                  },
                                                ),
                                                IconButton(
                                                  icon: Icon(
                                                    Icons.edit,
                                                    color: Colors.orange,
                                                  ),
                                                  onPressed: () {
                                                    // Handle edit article
                                                  },
                                                ),
                                                IconButton(
                                                  icon: Icon(
                                                    Icons.delete,
                                                    color: Colors.red,
                                                  ),
                                                  onPressed: () {
                                                    // Handle delete article
                                                  },
                                                ),
                                              ],
                                            )
                                            : SizedBox.shrink();
                                      },
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
  }
}
