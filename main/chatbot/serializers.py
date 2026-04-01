from rest_framework import serializers
from .models import ChatMessage

class ChatRequestSerializer(serializers.Serializer):
<<<<<<< HEAD:auth/chatbot/serializers.py
    message = serializers.CharField(required=True, max_length=5000, help_text="User message to send to the chatbot")
    system_prompt = serializers.CharField(required=False, default='You are a helpful AI assistant.', max_length=2000, help_text="Custom system prompt for the chatbot")
    session_id = serializers.CharField(required=False, max_length=100, help_text="Session ID for conversation continuity")
    def validate_message(self, value):
        if not value.strip():
            raise serializers.ValidationError("Message cannot be empty")
        return value.strip()

class ChatResponseSerializer(serializers.Serializer):
    success = serializers.BooleanField(default=True)
    message = serializers.CharField()
    response = serializers.CharField()
    session_id = serializers.CharField()
=======
    message = serializers.CharField(required=True,max_length=5000,)
    session_id = serializers.CharField(required=False,max_length=100,allow_blank=False,)

    def validate_message(self, value):
        stripped = value.strip()
        if not stripped:
            raise serializers.ValidationError("Message cannot be empty or whitespace.")
        return stripped

    def validate_session_id(self, value):
        return value.strip() if value else value

class ChatResponseSerializer(serializers.Serializer):
    success = serializers.BooleanField()
    message = serializers.CharField(help_text="The user's original message")
    response = serializers.CharField(help_text="WanderBot's reply")
    session_id = serializers.CharField(help_text="Use this in subsequent requests to maintain conversation context")
>>>>>>> upstream/main:main/chatbot/serializers.py
    created_at = serializers.DateTimeField()

class ChatHistorySerializer(serializers.ModelSerializer):
    class Meta:
        model = ChatMessage
        fields = ['id', 'user_message', 'bot_response', 'created_at']
<<<<<<< HEAD:auth/chatbot/serializers.py
        read_only_fields = ['id', 'user_message', 'bot_response', 'created_at']

class HistoryResponseSerializer(serializers.Serializer):
    success = serializers.BooleanField(default=True)
    session_id = serializers.CharField()
    count = serializers.IntegerField()
=======
        read_only_fields = fields

class HistoryResponseSerializer(serializers.Serializer):
    success = serializers.BooleanField()
    session_id = serializers.CharField()
    count = serializers.IntegerField(help_text="Total number of messages in this session")
>>>>>>> upstream/main:main/chatbot/serializers.py
    messages = ChatHistorySerializer(many=True)