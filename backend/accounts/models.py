from django.contrib.auth.models import AbstractBaseUser, BaseUserManager, PermissionsMixin
from django.db import models


class StudentUserManager(BaseUserManager):
    def create_user(
        self,
        email,
        full_name,
        phone_number,
        department,
        year_semester,
        student_id,
        password=None,
        **extra_fields,
    ):
        if not email:
            raise ValueError("Email address is required")

        if not password:
            raise ValueError("Password is required")

        email = self.normalize_email(email)

        user = self.model(
            email=email,
            full_name=full_name,
            phone_number=phone_number,
            department=department,
            year_semester=year_semester,
            student_id=student_id,
            **extra_fields,
        )

        user.set_password(password)
        user.save(using=self._db)

        return user

    def create_superuser(
        self,
        email,
        full_name,
        phone_number,
        department,
        year_semester,
        student_id,
        password=None,
        **extra_fields,
    ):
        extra_fields.setdefault("is_staff", True)
        extra_fields.setdefault("is_superuser", True)
        extra_fields.setdefault("is_active", True)

        return self.create_user(
            email=email,
            full_name=full_name,
            phone_number=phone_number,
            department=department,
            year_semester=year_semester,
            student_id=student_id,
            password=password,
            **extra_fields,
        )


class StudentUser(AbstractBaseUser, PermissionsMixin):
    email = models.EmailField(
        unique=True,
        db_index=True,
    )

    full_name = models.CharField(
        max_length=150,
    )

    phone_number = models.CharField(
        max_length=20,
    )

    department = models.CharField(
        max_length=100,
    )

    year_semester = models.CharField(
        max_length=50,
    )

    student_id = models.CharField(
        max_length=50,
        unique=True,
        db_index=True,
    )

    is_active = models.BooleanField(
        default=True,
    )

    is_staff = models.BooleanField(
        default=False,
    )

    created_at = models.DateTimeField(
        auto_now_add=True,
    )

    updated_at = models.DateTimeField(
        auto_now=True,
    )

    objects = StudentUserManager()

    USERNAME_FIELD = "email"

    REQUIRED_FIELDS = [
        "full_name",
        "phone_number",
        "department",
        "year_semester",
        "student_id",
    ]

    class Meta:
        db_table = "student_users"
        ordering = ["-created_at"]

    def __str__(self):
        return f"{self.full_name} ({self.email})"