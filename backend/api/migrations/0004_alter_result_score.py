# Generated by Django 3.2.5 on 2022-03-30 13:26

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0003_auto_20220330_1519'),
    ]

    operations = [
        migrations.AlterField(
            model_name='result',
            name='score',
            field=models.DecimalField(decimal_places=4, default=0.0, max_digits=7),
        ),
    ]
