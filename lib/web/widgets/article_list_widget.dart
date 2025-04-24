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

    return Column(
      children: [
        Expanded(
          child:
              articleProvider.articles.isEmpty
                  ? Center(
                    child: Text(
                      'No articles available.',
                      style: TextStyle(fontSize: 16.0, color: Colors.grey),
                    ),
                  )
                  : Column(
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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Expanded(
                              flex: 2,
                              child: Text(
                                'Title',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                'School Year',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                'Professor',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                'Created At',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                'Actions',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: articleProvider.articles.length,
                          itemBuilder: (context, index) {
                            final article = articleProvider.articles[index];
                            return Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                                vertical: 4.0,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withAlpha(
                                      (0.2 * 255).toInt(),
                                    ),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        article.title,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        '${DateFormat('yyyy').format(article.schoolYear.startDate)}/${DateFormat('yyyy').format(article.schoolYear.endDate)}',
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(article.professor.username),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        DateFormat(
                                          'yyyy-MM-dd HH:mm',
                                        ).format(article.createdAt),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Consumer<AuthProvider>(
                                        builder: (ctx, authProvider, _) {
                                          return authProvider.isProfessor
                                              ? Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
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
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Total Articles: ${articleProvider.articles.length}',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
