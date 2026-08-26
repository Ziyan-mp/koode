from rest_framework import serializers

from .models import StudentUser


class StudentRegistrationSerializer(serializers.ModelSerializer):
    password = serializers.CharField(
        write_only=True,
        min_length=6,
        style={"input_type": "password"},
    )

    class Meta:
        model = StudentUser
        fields = [
            "full_name",
            "email",
            "phone_number",
            "department",
            "year_semester",
            "student_id",
            "password",
        ]

    def validate_email(self, value):
        email = value.strip().lower()

        if StudentUser.objects.filter(email=email).exists():
            raise serializers.ValidationError(
                "An account with this email already exists."
            )

        return email

    def validate_student_id(self, value):
        student_id = value.strip()

        if StudentUser.objects.filter(student_id=student_id).exists():
            raise serializers.ValidationError(
                "An account with this student ID already exists."
            )

        return student_id

    def create(self, validated_data):
        password = validated_data.pop("password")

        user = StudentUser.objects.create_user(
            password=password,
            **validated_data,
        )

        return user