# Generated by Django 3.2.20 on 2023-08-07 10:24

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('app', '0002_auto_20230804_1013'),
    ]

    operations = [
        migrations.CreateModel(
            name='AreaInfo',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=32)),
                ('length', models.FloatField()),
                ('width', models.FloatField()),
                ('state', models.CharField(max_length=32)),
                ('ap1', models.CharField(max_length=32)),
                ('ap2', models.CharField(max_length=32)),
                ('ap3', models.CharField(max_length=32)),
                ('ap4', models.CharField(max_length=32)),
            ],
        ),
    ]
